module Menu.Item exposing (Item, view)

import Api.Scalar exposing (Decimal(..))
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
