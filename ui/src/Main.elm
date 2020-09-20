module Main exposing (main)

import Api.Query
import Browser
import Graphql.Http
import Graphql.Operation
import Graphql.SelectionSet exposing (SelectionSet)
import Html exposing (Html, div)
import Menu exposing (Menu)
import Menu.Item as Item



---- MODEL ----


type alias Model =
    { menu : Menu }


initialModel : Model
initialModel =
    { menu = [] }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getMenuQuery )



---- UPDATE ----


type Msg
    = MenuLoaded (Result (Graphql.Http.Error Menu) Menu)
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MenuLoaded (Ok menu) ->
            ( { model | menu = menu }, Cmd.none )

        MenuLoaded (Err _) ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ Menu.view model.menu
        ]



---- API ----


query : (Result (Graphql.Http.Error decodesTo) decodesTo -> Msg) -> SelectionSet decodesTo Graphql.Operation.RootQuery -> Cmd Msg
query msg =
    Graphql.Http.send msg << Graphql.Http.queryRequest "http://localhost:4000/api"


getMenuQuery : Cmd Msg
getMenuQuery =
    query MenuLoaded <| Api.Query.menuItems identity Item.selectionSet



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
