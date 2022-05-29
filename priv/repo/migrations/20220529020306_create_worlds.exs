defmodule RoundTable.Repo.Migrations.CreateWorlds do
  use Ecto.Migration

  def change do
    create table(:worlds) do
      add :name, :string
      add :genre, :string

      timestamps()
    end
  end
end
