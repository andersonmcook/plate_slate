defmodule PlateSlateWeb.Schema.Menu do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlateWeb.Resolvers.Menu

  input_object :menu_item_input do
    field :category_id, non_null(:id)
    field :description, :string
    field :name, non_null(:string)
    field :price, non_null(:decimal)
  end

  @desc "Filtering options for the menu item list"
  input_object :menu_item_filter do
    @desc "Added to the menu after this date"
    field :added_after, :date

    @desc "Added to the menu before this date"
    field :added_before, :date

    @desc "Matching a category name"
    field :category, :string

    @desc "Matching a name"
    field :name, :string

    @desc "Priced above a value"
    field :priced_above, :float

    @desc "Priced below a value"
    field :priced_below, :float

    @desc "Matching a tag"
    field :tag, :string
  end

  @desc "A menu item"
  object :menu_item do
    interfaces [:search_result]

    @desc "When the menu item was added"
    field :added_on, :string do
      arg :format, :date_format
    end

    @desc "The description of the menu item"
    field :description, :string

    @desc "The name of the menu item"
    field :name, :string

    @desc "The id of the menu item"
    field :id, :id

    @desc "The price of the menu item"
    field :price, :decimal
  end

  object :menu_item_result do
    field :menu_item, :menu_item
    field :errors, list_of(:input_error)
  end

  object :menu_mutations do
    field :create_menu_item, :menu_item_result do
      arg :input, non_null(:menu_item_input)
      resolve &Menu.create_item/3
    end
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
