defmodule TodoApi.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :name, :string
      add :description, :text
      add :priority, :integer

      timestamps()
    end

  end
end
