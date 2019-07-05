defmodule PlateSlateWeb.MenuItemsTest do
  use PlateSlateWeb.ConnCase, async: true

  setup do
    PlateSlate.Seeds.run()
  end

  test "menuItems field returns menu items" do
    query = """
    {
      menuItems {
        name
      }
    }
    """

    response =
      build_conn()
      |> get("/api",
        query: query
      )
      |> json_response(200)
      |> get_in(["data", "menuItems"])

    assert response == [
             %{"name" => "Bánh mì"},
             %{"name" => "Chocolate Milkshake"},
             %{"name" => "Croque Monsieur"},
             %{"name" => "French Fries"},
             %{"name" => "Lemonade"},
             %{"name" => "Masala Chai"},
             %{"name" => "Muffuletta"},
             %{"name" => "Papadum"},
             %{"name" => "Pasta Salad"},
             %{"name" => "Reuben"},
             %{"name" => "Soft Drink"},
             %{"name" => "Vada Pav"},
             %{"name" => "Vanilla Milkshake"},
             %{"name" => "Water"}
           ]
  end

  test "menuItems field returns menu items filtered by name" do
    query = """
    {
      menuItems(filter: {name: "reu"}) {
        name
      }
    }
    """

    response =
      build_conn()
      |> get("/api", query: query)
      |> json_response(200)
      |> get_in(["data", "menuItems"])

    assert response == [%{"name" => "Reuben"}]
  end

  test "menuItems field returns menuItems, filtering with a variable" do
    query = """
    query ($filter: MenuItemFilter!) {
      menuItems(filter: $filter) {
        name
      }
    }
    """

    variables = %{filter: %{"tag" => "Vegetarian", "category" => "Sandwiches"}}

    response =
      build_conn()
      |> get("/api", query: query, variables: variables)
      |> json_response(200)
      |> get_in(["data", "menuItems"])

    assert response == [%{"name" => "Vada Pav"}]
  end

  test "menuItems filtered by custom scalar" do
    query = """
    query ($filter: MenuItemFilter!) {
      menuItems(filter: $filter) {
        addedOn
        name
      }
    }
    """

    variables = %{filter: %{"addedBefore" => "2017-01-20"}}

    sides = PlateSlate.Repo.get_by!(PlateSlate.Menu.Category, name: "Sides")

    %PlateSlate.Menu.Item{
      name: "Garlic Fries",
      added_on: ~D[2017-01-01],
      price: 2.50,
      category: sides
    }
    |> PlateSlate.Repo.insert!()

    response =
      build_conn()
      |> get("/api", query: query, variables: variables)
      |> json_response(200)
      |> get_in(["data", "menuItems"])

    assert response == [%{"name" => "Garlic Fries", "addedOn" => "2017-01-01"}]
  end

  test "menuItems filtered by custom scalar with error" do
    query = """
    query ($filter: MenuItemFilter!) {
      menuItems(filter: $filter) {
        name
      }
    }
    """

    variables = %{filter: %{"addedBefore" => "not-a-date"}}

    response =
      build_conn()
      |> get("/api", query: query, variables: variables)
      |> json_response(200)
      |> Map.get("errors")

    assert response == [
             %{
               "locations" => [%{"column" => 0, "line" => 2}],
               "message" =>
                 "Argument \"filter\" has invalid value $filter.\nIn field \"addedBefore\": Expected type \"Date\", found \"not-a-date\"."
             }
           ]
  end
end
