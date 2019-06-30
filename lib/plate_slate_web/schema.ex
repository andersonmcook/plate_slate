defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  enum :sort_order do
    value :asc
    value :desc
  end

  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string

    @desc "Matching a category name"
    field :category, :string

    @desc "Matching a tag"
    field :tag, :string

    @desc "Priced above a value"
    field :priced_above, :float

    @desc "Priced below a value"
    field :priced_below, :float
  end

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      arg :filter, :menu_item_filter
      arg :order, type: :sort_order, default_value: :asc

      resolve &PlateSlateWeb.Resolvers.Menu.menu_items/3
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
