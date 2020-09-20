defmodule PlateSlateWeb.Router do
  use PlateSlateWeb, :router

  alias PlateSlateWeb.{
    Schema,
    UserSocket
  }

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: ["http://localhost:3000"]
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      interface: :playground,
      schema: Schema,
      socket: UserSocket
  end
end
