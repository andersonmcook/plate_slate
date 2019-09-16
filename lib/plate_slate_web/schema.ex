defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias PlateSlateWeb.Schema.Middleware.ChangesetErrors

  import_types Absinthe.Type.Custom

  import_types PlateSlateWeb.Schema.{
    Category,
    Menu,
    Ordering,
    Search
  }

  enum :sort_order do
    value :asc
    value :desc
  end

  @desc "An error encountered trying to persist input"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  mutation do
    import_fields :menu_mutations
    import_fields :ordering_mutations
  end

  query do
    import_fields :menu_queries
    import_fields :search_queries
  end

  subscription do
    import_fields :ordering_subscriptions
  end

  @impl true
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
