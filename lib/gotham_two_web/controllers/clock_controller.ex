defmodule GothamTwoWeb.ClockController do
  use GothamTwoWeb, :controller

  alias GothamTwo.Api
  alias GothamTwo.Api.Clock

  action_fallback GothamTwoWeb.FallbackController

  def index(conn, %{"userID" => id} = _params) do
    clocks = Api.get_clocks_by_user_id(id)
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params, "userID" => user_id}) do
    clock_params_with_user = Map.put(clock_params, "user_id", user_id)

    with {:ok, %Clock{} = clock} <- Api.create_clock(clock_params_with_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock.id}") # Modified this line to get the ID of the clock
      |> render(:show, clock: clock)
    end
end


  def show(conn, %{"id" => id}) do
    clock = Api.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Api.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Api.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Api.get_clock!(id)

    with {:ok, %Clock{}} <- Api.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
