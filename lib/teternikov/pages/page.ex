defmodule Teternikov.Pages.Page do
  use Ecto.Schema
  import Ecto.Changeset


  schema "pages" do
    field :body, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:url, :title, :body])
    |> validate_required([:url, :title, :body])
    |> unique_constraint(:url)
  end

  # def description do
  #   :title <> 
  # end

  # def keywords do
  #   :title <> " тантра, йога, парная, с партнером, хатха, кундалини, шакти, шива, искусство любить, лев, тетерников, рэйки, мужчина и женщина, интегральный, личностный, развитие, духовный, тренинг, семинар, регулярные занятия, школа, трансцендентальный, опыт, взаимоотношения, семья, сексуальность, духовность"
  # end
end
