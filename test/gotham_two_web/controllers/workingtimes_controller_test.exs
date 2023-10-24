defmodule GothamTwoWeb.WorkingtimesControllerTest do
  use GothamTwoWeb.ConnCase

  import GothamTwo.ApiFixtures

  alias GothamTwo.Api.Workingtimes

  @create_attrs %{
    start: ~N[2023-10-23 07:57:00],
    end: ~N[2023-10-23 07:57:00]
  }
  @update_attrs %{
    start: ~N[2023-10-24 07:57:00],
    end: ~N[2023-10-24 07:57:00]
  }
  @invalid_attrs %{start: nil, end: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workingtimes", %{conn: conn} do
      conn = get(conn, ~p"/api/workingtimes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workingtimes" do
    test "renders workingtimes when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/workingtimes", workingtimes: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/workingtimes/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2023-10-23T07:57:00",
               "start" => "2023-10-23T07:57:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/workingtimes", workingtimes: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workingtimes" do
    setup [:create_workingtimes]

    test "renders workingtimes when data is valid", %{conn: conn, workingtimes: %Workingtimes{id: id} = workingtimes} do
      conn = put(conn, ~p"/api/workingtimes/#{workingtimes}", workingtimes: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/workingtimes/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2023-10-24T07:57:00",
               "start" => "2023-10-24T07:57:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, workingtimes: workingtimes} do
      conn = put(conn, ~p"/api/workingtimes/#{workingtimes}", workingtimes: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workingtimes" do
    setup [:create_workingtimes]

    test "deletes chosen workingtimes", %{conn: conn, workingtimes: workingtimes} do
      conn = delete(conn, ~p"/api/workingtimes/#{workingtimes}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/workingtimes/#{workingtimes}")
      end
    end
  end

  defp create_workingtimes(_) do
    workingtimes = workingtimes_fixture()
    %{workingtimes: workingtimes}
  end
end
