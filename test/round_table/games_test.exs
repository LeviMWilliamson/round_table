defmodule RoundTable.GamesTest do
  use RoundTable.DataCase

  alias RoundTable.Games

  describe "campaigns" do
    alias RoundTable.Games.Campaign

    import RoundTable.GamesFixtures

    @invalid_attrs %{name: nil}

    test "list_campaigns/0 returns all campaigns" do
      campaign = campaign_fixture()
      assert Games.list_campaigns() == [campaign]
    end

    test "get_campaign!/1 returns the campaign with given id" do
      campaign = campaign_fixture()
      assert Games.get_campaign!(campaign.id) == campaign
    end

    test "create_campaign/1 with valid data creates a campaign" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Campaign{} = campaign} = Games.create_campaign(valid_attrs)
      assert campaign.name == "some name"
    end

    test "create_campaign/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_campaign(@invalid_attrs)
    end

    test "update_campaign/2 with valid data updates the campaign" do
      campaign = campaign_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Campaign{} = campaign} = Games.update_campaign(campaign, update_attrs)
      assert campaign.name == "some updated name"
    end

    test "update_campaign/2 with invalid data returns error changeset" do
      campaign = campaign_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_campaign(campaign, @invalid_attrs)
      assert campaign == Games.get_campaign!(campaign.id)
    end

    test "delete_campaign/1 deletes the campaign" do
      campaign = campaign_fixture()
      assert {:ok, %Campaign{}} = Games.delete_campaign(campaign)
      assert_raise Ecto.NoResultsError, fn -> Games.get_campaign!(campaign.id) end
    end

    test "change_campaign/1 returns a campaign changeset" do
      campaign = campaign_fixture()
      assert %Ecto.Changeset{} = Games.change_campaign(campaign)
    end
  end
end
