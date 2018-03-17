defmodule TeternikovWeb.Router do
  use TeternikovWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Coherence.Authentication.Session)
  end

  pipeline :protected do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Coherence.Authentication.Session, protected: true)
  end

  pipeline :admin_layout do
    plug(:put_layout, {TeternikovWeb.LayoutView, "one-solid-box.html"})
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through([:browser, :admin_layout])
    coherence_routes()
  end

  scope "/", TeternikovWeb do
    pipe_through([:protected, :admin_layout])

    scope "/admin" do
      resources("/pages", AdminPageController)
    end
  end

  scope "/", TeternikovWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", IndexController, :index)

    get("/*path", PageController, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TeternikovWeb do
  #   pipe_through :api
  # end
end
