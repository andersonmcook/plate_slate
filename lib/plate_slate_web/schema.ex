defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

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
end
