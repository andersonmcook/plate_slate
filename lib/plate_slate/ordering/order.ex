defmodule PlateSlate.Ordering.Order do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias PlateSlate.Ordering.Item

  schema "orders" do
    embeds_many :items, Item
    field :customer_number, :integer, read_after_writes: true
    field :ordered_at, :utc_datetime, read_after_writes: true
    field :state, :string, read_after_writes: true
    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:customer_number])
    |> cast_embed(:items)
    |> validate_required([:customer_number])
  end
end
