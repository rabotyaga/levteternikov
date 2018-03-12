defmodule TeternikovWeb.Router do
  use TeternikovWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TeternikovWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", IndexController, :index)

    scope "/admin" do
      resources("/pages", AdminPageController)
    end

    get("/*path", PageController, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TeternikovWeb do
  #   pipe_through :api
  # end
end
