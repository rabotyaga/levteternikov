defmodule TeternikovWeb.Router do
  use TeternikovWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TeternikovWeb do
    pipe_through :browser # Use the default browser stack

    get "/", IndexController, :index

    scope "/admin" do
      resources "/pages", PageController
    end

    get "/*path", PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", TeternikovWeb do
  #   pipe_through :api
  # end
end
