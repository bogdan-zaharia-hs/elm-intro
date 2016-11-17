module BegginerMain exposing (main)

import Html exposing (Html, text)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }


type alias Model =
    {}


type Msg
    = NoOp


model : Model
model =
    {}


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


view : Model -> Html Msg
view model =
    text "Hello Begginer World!"
