# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :teternikov, ecto_repos: [Teternikov.Repo]

# Configures the endpoint
config :teternikov, TeternikovWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/QFK047I2IvVrSZ+yrktbpyQhnwDySBhAjEHNI8nDxUSzTTV9n9YbyvEi4Ia7pkG",
  render_errors: [view: TeternikovWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Teternikov.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Teternikov.Coherence.User,
  repo: Teternikov.Repo,
  module: Teternikov,
  web_module: TeternikovWeb,
  router: TeternikovWeb.Router,
  messages_backend: TeternikovWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [
    :authenticatable,
    :recoverable,
    :lockable,
    :trackable,
    :unlockable_with_token,
    :registerable
  ]

config :coherence, TeternikovWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"

# %% End Coherence Configuration %%
