defmodule RoundTableWeb.CampaignLive.Show do
  use RoundTableWeb, :live_view

  alias RoundTable.Games

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:campaign, Games.get_campaign!(id))}
  end

  defp page_title(:show), do: "Show Campaign"
  defp page_title(:edit), do: "Edit Campaign"
end
