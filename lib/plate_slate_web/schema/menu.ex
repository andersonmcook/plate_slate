defmodule PlateSlateWeb.Schema.Menu do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlateWeb.Resolvers.Menu

  @desc "Filtering options for the menu item list"
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

    @desc "Added to the menu before this date"
    field :added_before, :date

    @desc "Added to the menu after this date"
    field :added_after, :date
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
  end

  object :menu_queries do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      arg :filter, :menu_item_filter
      arg :order, type: :sort_order, default_value: :asc

      resolve &Menu.menu_items/3
    end
  end
end
