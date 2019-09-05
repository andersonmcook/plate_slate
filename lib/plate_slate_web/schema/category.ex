defmodule PlateSlateWeb.Schema.Category do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlateWeb.Resolvers.Menu

  @desc "A category of menu items"
  object :category do
    interfaces [:search_result]

    field :description, :string

    field :items, list_of(:menu_item) do
      resolve &Menu.items_for_category/3
    end

    field :name, :string
  end
end
