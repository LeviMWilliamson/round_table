defmodule RoundTable.Worlds.World do
  use Ecto.Schema
  import Ecto.Changeset

  schema "worlds" do
    field :genre, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(world, attrs) do
    world
    |> cast(attrs, [:name, :genre])
    |> validate_required([:name, :genre])
  end
end
