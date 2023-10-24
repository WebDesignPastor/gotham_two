defmodule GothamTwoWeb.WorkingtimesJSON do
  alias GothamTwo.Api.Workingtimes

  @doc """
  Renders a list of workingtimes.
  """
  def index(%{workingtimes: workingtimes}) do
    %{data: for(workingtimes <- workingtimes, do: data(workingtimes))}
  end

  @doc """
  Renders a single workingtimes.
  """
  def show(%{workingtimes: workingtimes}) do
    %{data: data(workingtimes)}
  end

  defp data(%Workingtimes{} = workingtimes) do
    %{
      id: workingtimes.id,
      start: workingtimes.start,
      end: workingtimes.end
    }
  end
end
