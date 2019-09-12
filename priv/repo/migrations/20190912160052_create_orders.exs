defmodule PlateSlate.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :customer_number, :serial
      add :items, :map
      add :ordered_at, :utc_datetime, default: fragment("now()"), null: false
      add :state, :string, default: "created", null: false

      timestamps()
    end
  end
end
