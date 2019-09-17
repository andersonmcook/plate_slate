defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias PlateSlateWeb.Schema.Middleware.{
    ChangesetErrors,
    FormatDate
  }

  import_types Absinthe.Type.Custom

  import_types PlateSlateWeb.Schema.{
    Category,
    Menu,
    Ordering,
    Search
  }

  @desc "sort order type"
  enum :sort_order do
    value :asc
    value :desc
  end

  @desc "date format type"
  enum :date_format do
    value :mmm_dd_yyyy
    value :relative, description: "human readable time elapsed"
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
    import_fields :category_queries
    import_fields :menu_queries
    import_fields :search_queries
  end

  subscription do
    import_fields :ordering_subscriptions
  end

  @impl true
  def context(ctx) do
    ~w(items)a
    |> Enum.reduce(
      Dataloader.new(),
      &Dataloader.add_source(&2, &1, Dataloader.Ecto.new(PlateSlate.Repo))
    )
    |> (&Map.put(ctx, :loader, &1)).()
  end

  @impl true
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ChangesetErrors]
  end

  def middleware(middleware, %{identifier: identifier} = field, object)
      when identifier in [:added_on] do
    Absinthe.Schema.replace_default(middleware, {FormatDate, identifier}, field, object)
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  @impl true
  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
