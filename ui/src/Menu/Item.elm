module Menu.Item exposing (Item, selectionSet, view)

import Api.Object
import Api.Object.MenuItem
import Api.Scalar exposing (Decimal(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (Html, div, p, text)


type alias Item =
    { id : Api.Scalar.Id
    , name : String
    , price : Api.Scalar.Decimal
    }


view : Item -> Html msg
view item =
    div []
        [ p [] [ text item.name ]
        , p [] [ text ("$" ++ toString item.price) ]
        ]


toString : Api.Scalar.Decimal -> String
toString (Decimal d) =
    d


selectionSet : SelectionSet Item Api.Object.MenuItem
selectionSet =
    Item
        |> SelectionSet.succeed
        |> SelectionSet.with Api.Object.MenuItem.id
        |> SelectionSet.with Api.Object.MenuItem.name
        |> SelectionSet.with Api.Object.MenuItem.price
