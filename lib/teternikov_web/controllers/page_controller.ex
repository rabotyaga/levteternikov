defmodule TeternikovWeb.PageController do
  use TeternikovWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
