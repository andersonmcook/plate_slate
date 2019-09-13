defmodule PlateSlate.Menu.Item do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias PlateSlate.Menu.{
    Category,
    ItemTag
  }

  schema "items" do
    belongs_to :category, Category
    field :added_on, :date
    field :description, :string
    field :name, :string
    field :price, :decimal
    many_to_many :tags, ItemTag, join_through: "items_taggings"
    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = item, attrs) do
    item
    |> cast(attrs, [:added_on, :description, :name, :price])
    |> validate_required([:name, :price])
    |> foreign_key_constraint(:category)
    |> unique_constraint(:name)
  end
end
