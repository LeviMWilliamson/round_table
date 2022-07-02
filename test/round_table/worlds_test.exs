defmodule RoundTable.WorldsTest do
  use RoundTable.DataCase

  alias RoundTable.Worlds

  describe "worlds" do
    alias RoundTable.Worlds.World

    import RoundTable.WorldsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_worlds/0 returns all worlds" do
      world = world_fixture()
      assert Worlds.list_worlds() == [world]
    end

    test "get_world!/1 returns the world with given id" do
      world = world_fixture()
      assert Worlds.get_world!(world.id) == world
    end

    test "create_world/1 with valid data creates a world" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %World{} = world} = Worlds.create_world(valid_attrs)
      assert world.description == "some description"
      assert world.name == "some name"
    end

    test "create_world/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Worlds.create_world(@invalid_attrs)
    end

    test "update_world/2 with valid data updates the world" do
      world = world_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %World{} = world} = Worlds.update_world(world, update_attrs)
      assert world.description == "some updated description"
      assert world.name == "some updated name"
    end

    test "update_world/2 with invalid data returns error changeset" do
      world = world_fixture()
      assert {:error, %Ecto.Changeset{}} = Worlds.update_world(world, @invalid_attrs)
      assert world == Worlds.get_world!(world.id)
    end

    test "delete_world/1 deletes the world" do
      world = world_fixture()
      assert {:ok, %World{}} = Worlds.delete_world(world)
      assert_raise Ecto.NoResultsError, fn -> Worlds.get_world!(world.id) end
    end

    test "change_world/1 returns a world changeset" do
      world = world_fixture()
      assert %Ecto.Changeset{} = Worlds.change_world(world)
    end
  end
end
