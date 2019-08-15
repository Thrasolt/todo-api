defmodule TodoApi.Directory.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :description, :string
    field :name, :string
    field :priority, :integer

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name, :description, :priority])
    |> validate_required([:name, :description, :priority])
  end
end
