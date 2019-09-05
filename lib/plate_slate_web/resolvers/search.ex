defmodule PlateSlateWeb.Resolvers.Search do
  @moduledoc false

  alias PlateSlate.Menu

  def search(_, %{matching: term}, _) do
    {:ok, Menu.search(term)}
  end
end
