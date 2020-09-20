module Menu exposing (Menu, view)

import Html exposing (Html, div)
import Menu.Item as Item exposing (Item)


type alias Menu =
    List Item


view : Menu -> Html msg
view menu =
    div [] (List.map Item.view menu)
