# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :plate_slate,
  ecto_repos: [PlateSlate.Repo]

# Configures the endpoint
config :plate_slate, PlateSlateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mf1tcTUis1TXZk/t1qGcmnz0EJaruHK4igLXNKVrva6yjuItRuOlLm4Fm0lXFRth",
  render_errors: [view: PlateSlateWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: PlateSlate.PubSub


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  level: :info,
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
