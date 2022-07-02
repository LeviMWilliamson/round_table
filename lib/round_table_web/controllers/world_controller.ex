defmodule RoundTableWeb.WorldController do
  use RoundTableWeb, :controller

  alias RoundTable.Worlds
  alias RoundTable.Worlds.World

  def index(conn, _params) do
    worlds = Worlds.list_worlds()
    render(conn, "index.html", worlds: worlds)
  end

  def new(conn, _params) do
    changeset = Worlds.change_world(%World{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"world" => world_params}) do
    association = Ecto.build_assoc(conn.assigns.current_user, :worlds)
    case Worlds.create_world(association, world_params) do
      {:ok, world} ->
        conn
        |> put_flash(:info, "World created successfully.")
        |> redirect(to: Routes.world_path(conn, :show, world))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    world = Worlds.get_world!(id)
    render(conn, "show.html", world: world)
  end

  def edit(conn, %{"id" => id}) do
    world = Worlds.get_world!(id)
    changeset = Worlds.change_world(world)
    render(conn, "edit.html", world: world, changeset: changeset)
  end

  def update(conn, %{"id" => id, "world" => world_params}) do
    world = Worlds.get_world!(id)

    case Worlds.update_world(world, world_params) do
      {:ok, world} ->
        conn
        |> put_flash(:info, "World updated successfully.")
        |> redirect(to: Routes.world_path(conn, :show, world))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", world: world, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    world = Worlds.get_world!(id)
    {:ok, _world} = Worlds.delete_world(world)

    conn
    |> put_flash(:info, "World deleted successfully.")
    |> redirect(to: Routes.world_path(conn, :index))
  end
end
