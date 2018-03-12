defmodule TeternikovWeb.IndexControllerTest do
  use TeternikovWeb.ConnCase

  alias Teternikov.Pages

  @create_attrs %{body: "Index", title: "Index", url: "index"}

  def fixture(:page) do
    {:ok, page} = Pages.create_page(@create_attrs)
    page
  end

  defp create_page(_) do
    page = fixture(:page)
    {:ok, page: page}
  end

  describe "index" do
    setup [:create_page]

    test "renders index", %{conn: conn} do
      conn = get(conn, index_path(conn, :index))
      assert html_response(conn, 200) =~ "Index"
    end
  end
end
