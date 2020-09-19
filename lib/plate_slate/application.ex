defmodule PlateSlate.Application do
  @moduledoc false

  use Application

  alias PlateSlate.Repo
  alias PlateSlateWeb.Endpoint

  def start(_type, _args) do
    children = [
      Repo,
      Endpoint,
      {Phoenix.PubSub, [name: PlateSlate.PubSub, adapter: Phoenix.PubSub.PG2]},
      {Absinthe.Subscription, [Endpoint]}
    ]

    opts = [strategy: :one_for_one, name: PlateSlate.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
