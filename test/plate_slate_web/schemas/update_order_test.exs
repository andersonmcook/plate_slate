defmodule PlateSlateWeb.UpdateOrderTest do
  use PlateSlateWeb.SubscriptionCase

  @mutation """
  mutation ($id: ID!) {
    readyOrder(id: $id) {
      errors {
        message
      }
    }
  }
  """

  @subscription """
  subscription ($id: ID!) {
    updateOrder(id: $id) {
      state
    }
  }
  """

  test "subscribe to order updates", %{socket: socket} do
    reuben = menu_item("Reuben")

    {:ok, order_1} =
      PlateSlate.Ordering.create_order(%{
        customer_number: 123,
        items: [%{menu_item_id: reuben.id, quantity: 2}]
      })

    {:ok, order_2} =
      PlateSlate.Ordering.create_order(%{
        customer_number: 456,
        items: [%{menu_item_id: reuben.id, quantity: 1}]
      })

    ref = push_doc(socket, @subscription, variables: %{"id" => order_1.id})
    assert_reply ref, :ok, %{subscriptionId: _subscription_ref_1}
    ref = push_doc(socket, @subscription, variables: %{"id" => order_2.id})
    assert_reply ref, :ok, %{subscriptionId: subscription_ref_2}
    ref = push_doc(socket, @mutation, variables: %{"id" => order_2.id})
    assert_reply ref, :ok, reply

    refute reply[:errors]
    refute reply[:data]["readyOrder"]["errors"]
    assert_push "subscription:data", push

    expected = %{
      result: %{data: %{"updateOrder" => %{"state" => "ready"}}},
      subscriptionId: subscription_ref_2
    }

    assert expected == push
  end
end
