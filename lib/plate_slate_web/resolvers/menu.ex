defmodule PlateSlateWeb.Resolvers.Menu do
  @moduledoc false

  def menu_items(_, args, _) do
    {:ok, PlateSlate.Menu.list_items(args)}
  end

  def items_for_category(category, _, _) do
    {:ok,
     category
     |> Ecto.assoc(:items)
     |> PlateSlate.Repo.all()}
  end
end
