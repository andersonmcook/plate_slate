defmodule PlateSlateWeb.Schema.Middleware.FormatDate do
  @moduledoc """
  Date Formatting middleware

  * Note: this does not currently put the date into the user's timezone
  """

  @behaviour Absinthe.Middleware

  @impl true
  @doc """
  Formats date if provided a `format`, otherwise gets the raw value.
  """
  def call(%{definition: %{argument_data: %{format: format}}, source: source} = resolution, key) do
    %{
      resolution
      | state: :resolved,
        value:
          source
          |> Map.get(key)
          |> format_date(format)
    }
  end

  def call(%{source: source} = resolution, key) do
    %{resolution | state: :resolved, value: Map.get(source, key)}
  end

  defp format_date(nil, _), do: nil
  defp format_date(date, :mmm_dd_yyyy), do: Timex.format!(date, "{Mshort} {0D} {YYYY}")
  defp format_date(date, :relative), do: Timex.from_now(date)
end
