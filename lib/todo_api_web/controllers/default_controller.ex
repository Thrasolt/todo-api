
defmodule TodoApiWeb.DefaultController do
  use TodoApiWeb, :controller

  def index(conn, _params) do
    text conn, "TodoApi!"
  end
end
