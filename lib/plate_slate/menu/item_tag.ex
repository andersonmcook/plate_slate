defmodule PlateSlate.Menu.ItemTag do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias PlateSlate.Menu.Item

  schema "item_tags" do
    field :description
    field :name, :string, null: false

    many_to_many :items, Item, join_through: "items_taggings"

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = item_tag, attrs) do
    item_tag
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
