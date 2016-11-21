module Main exposing (main)

import Html exposing (Html, text)
import Mouse exposing (Position)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    Position


type Msg
    = MouseMoved Position


init : ( Model, Cmd Msg )
init =
    ( Position 0 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMoved position ->
            ( position, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves MouseMoved


view : Model -> Html Msg
view model =
    text (toString model)
