defmodule PlateSlateWeb.Resolvers.Ordering do
  @moduledoc false

  alias PlateSlate.Ordering

  def place_order(_, %{input: input}, _) do
    input
    |> Ordering.create_order()
    |> case do
      {:ok, order} -> {:ok, %{order: order}}
      {:error, changeset} -> {:ok, %{errors: transform_errors(changeset)}}
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn {key, message} -> %{key: key, message: message} end)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
