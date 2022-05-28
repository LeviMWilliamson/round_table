defmodule RoundTable.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RoundTable.Games` context.
  """

  @doc """
  Generate a campaign.
  """
  def campaign_fixture(attrs \\ %{}) do
    {:ok, campaign} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> RoundTable.Games.create_campaign()

    campaign
  end
end
