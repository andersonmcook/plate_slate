defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      resolve fn _, _, _ ->
        {:ok, PlateSlate.Menu.list_items()}
      end
    end
  end

  @desc "A menu item"
  object :menu_item do
    @desc "When the menu item was added"
    field :added_on, :date

    @desc "The description of the menu item"
    field :description, :string

    @desc "The name of the menu item"
    field :name, :string

    @desc "The price of the menu item"
    field :price, :decimal

    @desc "The id of the menu item"
    field :id, :id

    # category_id
    # tags list_of(:item_tag)
  end
end
