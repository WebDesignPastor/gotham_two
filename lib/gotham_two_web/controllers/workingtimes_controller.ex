defmodule GothamTwoWeb.WorkingtimesController do
  use GothamTwoWeb, :controller

  alias GothamTwo.Api
  alias GothamTwo.Api.Workingtimes

  action_fallback GothamTwoWeb.FallbackController

  # def index(conn, _params) do
  #   workingtimes = Api.list_workingtimes()
  #   render(conn, :index, workingtimes: workingtimes)
  # end

  def index(conn, %{"userID" => user, "start" => start_time, "end" => end_time}) do
    workingtimes = Api.get_working_time_by_user_start_and_end(user, start_time, end_time)
    render(conn, :index, workingtimes: [workingtimes])
  end


  def create(conn, %{"userID" => id, "workingtimes" => working_time_params}) do
    id = String.to_integer(id)
    with {:ok, %Workingtimes{} = working_time} <- Api.create_workingtimes(id, working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{working_time}")
      |> render(:show, workingtimes: working_time)
    end
  end

  def show(conn, %{"userID" => _user_id, "id" => id}) do
    workingtimes = Api.get_workingtimes!(id)
    render(conn, :show, workingtimes: workingtimes)
  end

  @spec update(any(), map()) :: any()
  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = Api.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- Api.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, :show, workingtimes: workingtimes)
    end
  end

  @spec delete(any(), map()) :: any()
  def delete(conn, %{"id" => id}) do
    workingtimes = Api.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- Api.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
