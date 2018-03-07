defmodule TeternikovWeb.IndexController do
  use TeternikovWeb, :controller

  alias Teternikov.Pages

  def index(conn, _params) do
    page = Pages.get_page_by_url!("index")
    render(conn, "index.html", page: page)
  end
end
