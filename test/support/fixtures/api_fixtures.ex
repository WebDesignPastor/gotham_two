defmodule GothamTwo.ApiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GothamTwo.Api` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> GothamTwo.Api.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2023-10-23 07:57:00]
      })
      |> GothamTwo.Api.create_clock()

    clock
  end

  @doc """
  Generate a workingtimes.
  """
  def workingtimes_fixture(attrs \\ %{}) do
    {:ok, workingtimes} =
      attrs
      |> Enum.into(%{
        end: ~N[2023-10-23 07:57:00],
        start: ~N[2023-10-23 07:57:00]
      })
      |> GothamTwo.Api.create_workingtimes()

    workingtimes
  end
end
