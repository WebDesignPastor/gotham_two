defmodule GothamTwoWeb.UserController do
  use GothamTwoWeb, :controller

  alias GothamTwo.Api
  alias GothamTwo.Api.User

  action_fallback GothamTwoWeb.FallbackController

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, %{"email" => email, "username" => username} = _params) do
    user = Api.get_user_by_email_and_username(email, username)
    render(conn, :index, users: [user])
  end

  # def index(conn, _params) do
  #   users = Api.list_users()
  #   render(conn, :index, users: users)
  # end

  @spec create(any(), map()) :: any()
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Api.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"userID" => id}) do
    user = Api.get_user!(id)
    render(conn, :show, user: user)
  end

  @spec update(any(), map()) :: any()
  def update(conn, %{"userID" => id, "user" => user_params}) do
    user = Api.get_user!(id)

    with {:ok, %User{} = user} <- Api.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Api.get_user!(id)

    with {:ok, %User{}} <- Api.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
