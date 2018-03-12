defmodule TeternikovWeb.ErrorViewTest do
  use TeternikovWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  # TODO: make controller test for 404 within layout?
  # test "renders 404.html" do
  #   assert render_to_string(TeternikovWeb.ErrorView, "404.html", []) == "Page not found"
  # end
  test "renders not_found.html" do
    assert render_to_string(TeternikovWeb.ErrorView, "not_found.html", []) =~ "404"
  end

  test "render 500.html" do
    assert render_to_string(TeternikovWeb.ErrorView, "500.html", []) == "Internal server error"
  end

  test "render any other" do
    assert render_to_string(TeternikovWeb.ErrorView, "505.html", []) == "Internal server error"
  end
end
