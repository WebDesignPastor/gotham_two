defmodule GothamTwo.Repo do
  use Ecto.Repo,
    otp_app: :gotham_two,
    adapter: Ecto.Adapters.Postgres
end
