defmodule TodoApi.DirectoryTest do
  use TodoApi.DataCase

  alias TodoApi.Directory

  describe "todos" do
    alias TodoApi.Directory.Todo

    @valid_attrs %{description: "some description", name: "some name", priority: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", priority: 43}
    @invalid_attrs %{description: nil, name: nil, priority: nil}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Directory.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Directory.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = Directory.create_todo(@valid_attrs)
      assert todo.description == "some description"
      assert todo.name == "some name"
      assert todo.priority == 42
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{} = todo} = Directory.update_todo(todo, @update_attrs)
      assert todo.description == "some updated description"
      assert todo.name == "some updated name"
      assert todo.priority == 43
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_todo(todo, @invalid_attrs)
      assert todo == Directory.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Directory.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Directory.change_todo(todo)
    end
  end
end
