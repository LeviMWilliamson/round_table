defmodule RoundTableWeb.WorldControllerTest do
  use RoundTableWeb.ConnCase

  import RoundTable.WorldsFixtures

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  describe "index" do
    test "lists all worlds", %{conn: conn} do
      conn = get(conn, Routes.world_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Worlds"
    end
  end

  describe "new world" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.world_path(conn, :new))
      assert html_response(conn, 200) =~ "New World"
    end
  end

  describe "create world" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.world_path(conn, :create), world: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.world_path(conn, :show, id)

      conn = get(conn, Routes.world_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show World"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.world_path(conn, :create), world: @invalid_attrs)
      assert html_response(conn, 200) =~ "New World"
    end
  end

  describe "edit world" do
    setup [:create_world]

    test "renders form for editing chosen world", %{conn: conn, world: world} do
      conn = get(conn, Routes.world_path(conn, :edit, world))
      assert html_response(conn, 200) =~ "Edit World"
    end
  end

  describe "update world" do
    setup [:create_world]

    test "redirects when data is valid", %{conn: conn, world: world} do
      conn = put(conn, Routes.world_path(conn, :update, world), world: @update_attrs)
      assert redirected_to(conn) == Routes.world_path(conn, :show, world)

      conn = get(conn, Routes.world_path(conn, :show, world))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, world: world} do
      conn = put(conn, Routes.world_path(conn, :update, world), world: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit World"
    end
  end

  describe "delete world" do
    setup [:create_world]

    test "deletes chosen world", %{conn: conn, world: world} do
      conn = delete(conn, Routes.world_path(conn, :delete, world))
      assert redirected_to(conn) == Routes.world_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.world_path(conn, :show, world))
      end
    end
  end

  defp create_world(_) do
    world = world_fixture()
    %{world: world}
  end
end
