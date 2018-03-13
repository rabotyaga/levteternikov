defmodule TeternikovWeb.PageController do
  use TeternikovWeb, :controller

  alias Teternikov.Pages

  plug(:put_layout, "one-solid-box.html")

  def show(conn, %{"path" => path}) do
    page = Pages.get_page_by_url!(Path.join(path))
    render(conn, "show_by_url.html", page: page, title: page.title)
  end
end
