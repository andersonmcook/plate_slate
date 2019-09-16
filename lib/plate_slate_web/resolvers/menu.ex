defmodule PlateSlateWeb.Resolvers.Menu do
  @moduledoc false

  alias PlateSlate.{
    Menu,
    Repo
  }

  def create_item(_, %{input: input}, _) do
    input
    |> Menu.create_item()
    |> case do
      {:ok, menu_item} ->
        {:ok, %{menu_item: menu_item}}

      error ->
        error
    end
  end

  def items_for_category(category, _, _) do
    {:ok,
     category
     |> Ecto.assoc(:items)
     |> Repo.all()}
  end

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end

  def categories(_, _, _) do
    {:ok, Menu.list_categories()}
  end
end
