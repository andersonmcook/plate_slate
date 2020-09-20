defmodule PlateSlateWeb.Schema.Category do
  @moduledoc false

  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias PlateSlateWeb.Resolvers.Menu

  @desc "A category of menu items"
  object :category do
    interfaces [:search_result]

    field :description, :string

    # without dataloader
    field :itemz, list_of(non_null(:menu_item)) do
      resolve &Menu.items_for_category/3
    end

    # with dataloader
    # dataloader/1 needs association and field name to align
    field :items, list_of(non_null(:menu_item)), resolve: dataloader(:items)

    field :name, non_null(:string)
  end

  object :category_queries do
    field :categories, non_null(list_of(non_null(:category))) do
      resolve &Menu.categories/3
    end
  end
end
