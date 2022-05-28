defmodule RoundTableWeb.CampaignLiveTest do
  use RoundTableWeb.ConnCase

  import Phoenix.LiveViewTest
  import RoundTable.GamesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_campaign(_) do
    campaign = campaign_fixture()
    %{campaign: campaign}
  end

  describe "Index" do
    setup [:create_campaign]

    test "lists all campaigns", %{conn: conn, campaign: campaign} do
      {:ok, _index_live, html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert html =~ "Listing Campaigns"
      assert html =~ campaign.name
    end

    test "saves new campaign", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert index_live |> element("a", "New Campaign") |> render_click() =~
               "New Campaign"

      assert_patch(index_live, Routes.campaign_index_path(conn, :new))

      assert index_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#campaign-form", campaign: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.campaign_index_path(conn, :index))

      assert html =~ "Campaign created successfully"
      assert html =~ "some name"
    end

    test "updates campaign in listing", %{conn: conn, campaign: campaign} do
      {:ok, index_live, _html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert index_live |> element("#campaign-#{campaign.id} a", "Edit") |> render_click() =~
               "Edit Campaign"

      assert_patch(index_live, Routes.campaign_index_path(conn, :edit, campaign))

      assert index_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#campaign-form", campaign: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.campaign_index_path(conn, :index))

      assert html =~ "Campaign updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes campaign in listing", %{conn: conn, campaign: campaign} do
      {:ok, index_live, _html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert index_live |> element("#campaign-#{campaign.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#campaign-#{campaign.id}")
    end
  end

  describe "Show" do
    setup [:create_campaign]

    test "displays campaign", %{conn: conn, campaign: campaign} do
      {:ok, _show_live, html} = live(conn, Routes.campaign_show_path(conn, :show, campaign))

      assert html =~ "Show Campaign"
      assert html =~ campaign.name
    end

    test "updates campaign within modal", %{conn: conn, campaign: campaign} do
      {:ok, show_live, _html} = live(conn, Routes.campaign_show_path(conn, :show, campaign))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Campaign"

      assert_patch(show_live, Routes.campaign_show_path(conn, :edit, campaign))

      assert show_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#campaign-form", campaign: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.campaign_show_path(conn, :show, campaign))

      assert html =~ "Campaign updated successfully"
      assert html =~ "some updated name"
    end
  end
end
