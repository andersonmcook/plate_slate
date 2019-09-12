defmodule PlateSlateWeb.Resolvers.Menu do
  @moduledoc false

  alias PlateSlate.Menu

  def create_item(_, %{input: input}, _) do
    input
    |> Menu.create_item()
    |> case do
      {:error, _} -> {:error, "Could not create menu item"}
      ok -> ok
    end
  end

  def items_for_category(category, _, _) do
    {:ok,
     category
     |> Ecto.assoc(:items)
     |> PlateSlate.Repo.all()}
  end

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end
end
