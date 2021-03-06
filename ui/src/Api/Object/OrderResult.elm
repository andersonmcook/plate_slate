-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.OrderResult exposing (..)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


errors :
    SelectionSet decodesTo Api.Object.InputError
    -> SelectionSet (Maybe (List (Maybe decodesTo))) Api.Object.OrderResult
errors object_ =
    Object.selectionForCompositeField "errors" [] object_ (identity >> Decode.nullable >> Decode.list >> Decode.nullable)


order :
    SelectionSet decodesTo Api.Object.Order
    -> SelectionSet (Maybe decodesTo) Api.Object.OrderResult
order object_ =
    Object.selectionForCompositeField "order" [] object_ (identity >> Decode.nullable)
