defmodule PlateSlateWeb.Schema.Ordering do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias PlateSlateWeb.Resolvers.Ordering

  input_object :order_item_input do
    field :menu_item_id, non_null(:id)
    field :quantity, non_null(:integer)
  end

  input_object :place_order_input do
    field :customer_number, :integer
    field :items, non_null(list_of(non_null(:order_item_input)))
  end

  object :order do
    field :customer_number, :integer
    field :id, :id
    field :items, list_of(:order_item)
    field :state, :string
  end

  object :order_item do
    field :name, :string
    field :quantity, :integer
  end

  object :order_result do
    field :errors, list_of(:input_error)
    field :order, :order
  end

  object :ordering_mutations do
    field :complete_order, :order_result do
      arg :id, non_null(:id)
      resolve &Ordering.complete_order/3
    end

    field :place_order, :order_result do
      arg :input, non_null(:place_order_input)
      resolve &Ordering.place_order/3
    end

    field :ready_order, :order_result do
      arg :id, non_null(:id)
      resolve &Ordering.ready_order/3
    end
  end

  object :ordering_subscriptions do
    field :new_order, :order do
      config fn _args, _info -> {:ok, topic: "*"} end
    end

    field :update_order, :order do
      arg :id, non_null(:id)
      config fn args, _info -> {:ok, topic: args.id} end

      trigger [:complete_order, :ready_order],
        topic: fn
          %{order: order} -> [order.id]
          _ -> []
        end

      resolve fn %{order: order}, _, _ -> {:ok, order} end
    end
  end
end
