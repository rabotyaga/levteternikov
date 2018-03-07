# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :teternikov,
  ecto_repos: [Teternikov.Repo]

# Configures the endpoint
config :teternikov, TeternikovWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/QFK047I2IvVrSZ+yrktbpyQhnwDySBhAjEHNI8nDxUSzTTV9n9YbyvEi4Ia7pkG",
  render_errors: [view: TeternikovWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Teternikov.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
