defmodule TeternikovWeb.PageController do
  use TeternikovWeb, :controller

  alias Teternikov.Pages
  alias Teternikov.Pages.Page

  def show(conn, %{"path" => path}) do
    page = Pages.get_page_by_url!(Path.join(path))
    render(conn, "show_by_url.html", page: page, title: page.title, nested: "one-solid-box.html")
  end
end
