defmodule PlateSlateWeb.NewOrderTest do
  use PlateSlateWeb.SubscriptionCase

  @mutation """
  mutation ($input: PlaceOrderInput!) {
    placeOrder(input: $input) {
      order {
        id
      }
    }
  }
  """

  @subscription """
  subscription {
    newOrder {
      customerNumber
    }
  }
  """

  test "new orders can be subscribed to", %{socket: socket} do
    # setup a subscription
    ref = push_doc(socket, @subscription)
    assert_reply(ref, :ok, %{subscriptionId: subscription_id})

    # run a mutation to trigger the subscription
    order_input = %{
      "customerNumber" => 24,
      "items" => [%{"menuItemId" => menu_item("Reuben").id, "quantity" => 2}]
    }

    ref = push_doc(socket, @mutation, variables: %{"input" => order_input})
    assert_reply(ref, :ok, reply)
    assert %{data: %{"placeOrder" => %{"order" => %{"id" => _}}}} = reply

    # check to see if we got subscription data
    expected = %{
      result: %{data: %{"newOrder" => %{"customerNumber" => 24}}},
      subscriptionId: subscription_id
    }

    assert_push("subscription:data", push)
    assert expected == push
  end
end
