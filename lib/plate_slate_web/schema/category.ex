defmodule PlateSlateWeb.Schema.Category do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlateWeb.Resolvers.Menu

  @desc "A category of menu items"
  object :category do
    field :items, list_of(:menu_item) do
      resolve &Menu.items_for_category/3
    end

    field :description, :string
    field :name, :string
  end
end
