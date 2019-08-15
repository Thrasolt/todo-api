defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller

  alias TodoApi.Directory
  alias TodoApi.Directory.Todo

  action_fallback TodoApiWeb.FallbackController

  def index(conn, _params) do
    todos = Directory.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Directory.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Directory.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Directory.get_todo!(id)

    with {:ok, %Todo{} = todo} <- Directory.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Directory.get_todo!(id)

    with {:ok, %Todo{}} <- Directory.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
