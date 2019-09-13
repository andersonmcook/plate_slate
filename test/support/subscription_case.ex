defmodule PlateSlateWeb.SubscriptionCase do
  @moduledoc """
  Defines the test case to be used by subscription tests
  """

  use ExUnit.CaseTemplate

  alias PlateSlate.{
    Menu.Item,
    Repo,
    Seeds
  }

  using do
    quote do
      alias PlateSlateWeb.{
        ChannelCase,
        Schema,
        UserSocket
      }

      use ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: Schema

      setup do
        Seeds.run()

        {:ok, socket} = Phoenix.ChannelTest.connect(UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)
        {:ok, socket: socket}
      end

      import unquote(__MODULE__), only: [menu_item: 1]
    end
  end

  def menu_item(name) do
    Repo.get_by!(Item, name: name)
  end
end
