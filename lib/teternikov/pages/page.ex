defmodule Teternikov.Pages.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field(:body, :string)
    field(:title, :string)
    field(:url, :string)

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:url, :title, :body])
    |> validate_required([:url, :title, :body])
    |> unique_constraint(:url)
  end
end
