defmodule TeternikovWeb.IndexControllerTest do
  use TeternikovWeb.ConnCase

  describe "index" do
    test "renders index", %{conn: conn} do
      conn = get conn, index_path(conn, :index)
      assert html_response(conn, 200) =~ "Index"
    end
  end
end
