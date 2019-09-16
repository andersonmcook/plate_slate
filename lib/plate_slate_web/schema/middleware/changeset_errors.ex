defmodule PlateSlateWeb.Schema.Middleware.ChangesetErrors do
  @moduledoc false

  @behaviour Absinthe.Middleware

  @impl true
  def call(%{errors: [%Ecto.Changeset{} = changeset]} = resolution, _) do
    %{resolution | errors: [], value: %{errors: transform_errors(changeset)}}
  end

  def call(resolution, _) do
    resolution
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
