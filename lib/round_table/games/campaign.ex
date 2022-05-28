defmodule RoundTable.Games.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campaigns" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
