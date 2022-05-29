defmodule RoundTable.WorldsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RoundTable.Worlds` context.
  """

  @doc """
  Generate a world.
  """
  def world_fixture(attrs \\ %{}) do
    {:ok, world} =
      attrs
      |> Enum.into(%{
        genre: "some genre",
        name: "some name"
      })
      |> RoundTable.Worlds.create_world()

    world
  end
end
