defmodule RoundTable.Repo do
  use Ecto.Repo,
    otp_app: :round_table,
    adapter: Ecto.Adapters.Postgres
end
