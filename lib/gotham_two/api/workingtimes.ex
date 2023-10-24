defmodule GothamTwo.Api.Workingtimes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :start, :naive_datetime
    field :end, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(workingtimes, attrs) do
    workingtimes
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
