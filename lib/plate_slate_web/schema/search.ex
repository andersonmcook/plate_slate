defmodule PlateSlateWeb.Schema.Search do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlate.Menu.{
    Category,
    Item
  }

  alias PlateSlateWeb.Resolvers.Search

  interface :search_result do
    field :name, :string

    resolve_type fn
      %Category{}, _resolution -> :category
      %Item{}, _resolution -> :menu_item
      _value, _resolution -> nil
    end
  end

  object :search_queries do
    field :search, list_of(:search_result) do
      arg :matching, non_null(:string)
      resolve &Search.search/3
    end
  end
end
