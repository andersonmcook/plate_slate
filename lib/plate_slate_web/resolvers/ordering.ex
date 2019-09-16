defmodule PlateSlateWeb.Resolvers.Ordering do
  @moduledoc false

  alias PlateSlate.Ordering
  alias PlateSlateWeb.Endpoint

  def complete_order(_, %{id: id}, _) do
    id
    |> Ordering.get_order!()
    |> Ordering.update_order(%{state: "complete"})
    |> case do
      {:ok, order} -> {:ok, %{order: order}}
      error -> error
    end
  end

  def place_order(_, %{input: input}, _) do
    input
    |> Ordering.create_order()
    |> case do
      {:ok, order} ->
        Absinthe.Subscription.publish(Endpoint, order, new_order: "*")
        {:ok, %{order: order}}

      error ->
        error
    end
  end

  def ready_order(_, %{id: id}, _) do
    id
    |> Ordering.get_order!()
    |> Ordering.update_order(%{state: "ready"})
    |> case do
      {:ok, order} -> {:ok, %{order: order}}
      error -> error
    end
  end
end
