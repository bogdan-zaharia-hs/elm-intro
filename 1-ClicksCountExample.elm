module Main exposing (main)

import Html exposing (Html, button, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }


type alias Model =
    Int


type Msg
    = CountClick


model : Model
model =
    0


update : Msg -> Model -> Model
update msg model =
    case msg of
        CountClick ->
            model + 1


view : Model -> Html Msg
view model =
    let
        buttonStyle =
            [ ( "padding", "8px" )
            , ( "margin", "16px" )
            , ( "font-size", "1.2em" )
            ]
    in
        button
            [ onClick CountClick
            , style buttonStyle
            ]
            [ text <| "Clicks: " ++ (toString model) ]
