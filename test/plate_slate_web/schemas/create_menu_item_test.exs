defmodule PlateSlateWeb.CreateMenuItemTest do
  use PlateSlateWeb.ConnCase, async: true

  import Ecto.Query

  alias PlateSlate.{
    Menu,
    Repo
  }

  setup do
    PlateSlate.Seeds.run()

    from(c in Menu.Category, where: c.name == "Sandwiches")
    |> Repo.one!()
    |> Map.fetch!(:id)
    |> Kernel.to_string()
    |> (&{:ok, category_id: &1}).()
  end

  @query """
  mutation ($menuItem: MenuItemInput!) {
    menuItem: createMenuItem(input: $menuItem) {
      description
      name
      price
    }
  }
  """

  test "createMenuItem field creates an item", %{category_id: category_id} do
    menu_item = %{
      "categoryId" => category_id,
      "description" => "Roast beef, caramelized onions, horseradish, ...",
      "name" => "French Dip",
      "price" => "5.75"
    }

    data =
      build_conn()
      |> post("/api", query: @query, variables: %{"menuItem" => menu_item})
      |> json_response(200)
      |> Map.get("data")

    assert data == %{
             "menuItem" => %{
               "description" => menu_item["description"],
               "name" => menu_item["name"],
               "price" => menu_item["price"]
             }
           }
  end
end
