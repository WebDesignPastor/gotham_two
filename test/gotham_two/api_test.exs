defmodule GothamTwo.ApiTest do
  use GothamTwo.DataCase

  alias GothamTwo.Api

  describe "users" do
    alias GothamTwo.Api.User

    import GothamTwo.ApiFixtures

    @invalid_attrs %{username: nil, email: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Api.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Api.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{username: "some username", email: "some email"}

      assert {:ok, %User{} = user} = Api.create_user(valid_attrs)
      assert user.username == "some username"
      assert user.email == "some email"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{username: "some updated username", email: "some updated email"}

      assert {:ok, %User{} = user} = Api.update_user(user, update_attrs)
      assert user.username == "some updated username"
      assert user.email == "some updated email"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_user(user, @invalid_attrs)
      assert user == Api.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Api.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Api.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Api.change_user(user)
    end
  end

  describe "clocks" do
    alias GothamTwo.Api.Clock

    import GothamTwo.ApiFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Api.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Api.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2023-10-23 07:57:00]}

      assert {:ok, %Clock{} = clock} = Api.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2023-10-23 07:57:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2023-10-24 07:57:00]}

      assert {:ok, %Clock{} = clock} = Api.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2023-10-24 07:57:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_clock(clock, @invalid_attrs)
      assert clock == Api.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Api.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Api.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Api.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias GothamTwo.Api.Workingtimes

    import GothamTwo.ApiFixtures

    @invalid_attrs %{start: nil, end: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtimes = workingtimes_fixture()
      assert Api.list_workingtimes() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert Api.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      valid_attrs = %{start: ~N[2023-10-23 07:57:00], end: ~N[2023-10-23 07:57:00]}

      assert {:ok, %Workingtimes{} = workingtimes} = Api.create_workingtimes(valid_attrs)
      assert workingtimes.start == ~N[2023-10-23 07:57:00]
      assert workingtimes.end == ~N[2023-10-23 07:57:00]
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      update_attrs = %{start: ~N[2023-10-24 07:57:00], end: ~N[2023-10-24 07:57:00]}

      assert {:ok, %Workingtimes{} = workingtimes} = Api.update_workingtimes(workingtimes, update_attrs)
      assert workingtimes.start == ~N[2023-10-24 07:57:00]
      assert workingtimes.end == ~N[2023-10-24 07:57:00]
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == Api.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = Api.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> Api.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = Api.change_workingtimes(workingtimes)
    end
  end
end
