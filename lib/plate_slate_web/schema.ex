defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      resolve fn _, _, _ ->
        {:ok, PlateSlate.Menu.list_items()}
      end
    end
  end

  object :menu_item do
    field :description, :string
    field :name, :string
    field :id, :id
  end
end
