defmodule GothamTwoWeb.WorkingtimesController do
  use GothamTwoWeb, :controller

  alias GothamTwo.Api
  alias GothamTwo.Api.Workingtimes

  action_fallback GothamTwoWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Api.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"workingtimes" => workingtimes_params}) do
    with {:ok, %Workingtimes{} = workingtimes} <- Api.create_workingtimes(workingtimes_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtimes}")
      |> render(:show, workingtimes: workingtimes)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtimes = Api.get_workingtimes!(id)
    render(conn, :show, workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = Api.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- Api.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, :show, workingtimes: workingtimes)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtimes = Api.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- Api.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
