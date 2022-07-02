defmodule RoundTable.Worlds.World do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "worlds" do
    field :description, :string
    field :name, :string
    belongs_to :user, RoundTable.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(world, attrs) do
    world
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
