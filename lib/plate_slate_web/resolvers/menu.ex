defmodule PlateSlateWeb.Resolvers.Menu do
  def menu_items(_, args, _) do
    {:ok, PlateSlate.Menu.list_items(args)}
  end
end
