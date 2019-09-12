defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  import_types PlateSlateWeb.Schema.{
    Category,
    Menu,
    # Ordering,
    Search
  }

  enum :sort_order do
    value :asc
    value :desc
  end

  mutation do
    import_fields :menu_mutations
  end

  query do
    import_fields :menu_queries
    import_fields :search_queries
  end
end
