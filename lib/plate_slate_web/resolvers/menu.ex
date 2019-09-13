defmodule PlateSlateWeb.Resolvers.Menu do
  @moduledoc false

  alias PlateSlate.Menu

  def create_item(_, %{input: input}, _) do
    input
    |> Menu.create_item()
    |> case do
      {:error, changeset} ->
        {:ok, %{errors: transform_errors(changeset)}}

      {:ok, menu_item} ->
        {:ok, %{menu_item: menu_item}}
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn {key, value} -> %{key: key, message: value} end)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
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
