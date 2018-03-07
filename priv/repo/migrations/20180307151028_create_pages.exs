defmodule Teternikov.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :url, :string
      add :title, :string
      add :body, :text

      timestamps()
    end

    create unique_index(:pages, [:url])
  end
end
