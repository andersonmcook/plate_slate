defmodule PlateSlate.Menu.Category do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias PlateSlate.Menu.Item

  schema "categories" do
    field :description, :string
    field :name, :string, null: false
    has_many :items, Item
    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = category, attrs) do
    category
    |> cast(attrs, [:description, :name])
    |> validate_required([:name])
  end
end
