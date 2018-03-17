defmodule TeternikovWeb.ErrorView do
  use TeternikovWeb, :view

  def render("404.html", assigns) do
    render(
      TeternikovWeb.ErrorView,
      "not_found.html",
      Map.put(assigns, :layout, {TeternikovWeb.LayoutView, "one-solid-box.html"})
    )
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end
end
