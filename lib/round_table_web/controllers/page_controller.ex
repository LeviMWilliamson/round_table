defmodule RoundTableWeb.PageController do
  use RoundTableWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def setup(conn, _params) do
    render(conn, "setup.html")
  end
end
