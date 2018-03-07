defmodule TeternikovWeb.PageController do
  use TeternikovWeb, :controller

  alias Teternikov.Pages
  alias Teternikov.Pages.Page

  def index(conn, _params) do
    pages = Pages.list_pages()
    render(conn, "index.html", pages: pages)
  end

  def new(conn, _params) do
    changeset = Pages.change_page(%Page{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case Pages.create_page(page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: page_path(conn, :show, page))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    page = Pages.get_page!(id)
    render(conn, "show.html", page: page)
  end

  def show(conn, %{"path" => path}) do
    page = Pages.get_page_by_url!(Path.join(path))
    render(conn, "show_by_url.html", page: page, title: page.title, nested: "one-solid-box.html")
  end

  def edit(conn, %{"id" => id}) do
    page = Pages.get_page!(id)
    changeset = Pages.change_page(page)
    render(conn, "edit.html", page: page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Pages.get_page!(id)

    case Pages.update_page(page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: page_path(conn, :show, page))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Pages.get_page!(id)
    {:ok, _page} = Pages.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
