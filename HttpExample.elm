module DefaultMain exposing (main)

import Html exposing (Html, br, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)
import Http
import Json.Decode as Decode


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Id =
    Int


type alias Post =
    { id : Id
    , title : String
    }


type alias Model =
    { post : Maybe (Result Http.Error Post)
    , requestedId : Id
    }


type Msg
    = LoadPost (Result Http.Error Post)
    | GetPostById String


init : ( Model, Cmd Msg )
init =
    ( { post = Nothing, requestedId = 1 }
    , getPost 1
    )


getPost : Id -> Cmd Msg
getPost id =
    let
        url =
            "https://jsonplaceholder.typicode.com/posts/" ++ (toString id)
    in
        Http.send LoadPost (Http.get url decodeStream)


decodeStream : Decode.Decoder Post
decodeStream =
    Decode.map2 Post
        (Decode.field "id" Decode.int)
        (Decode.field "titles" Decode.string)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadPost postData ->
            ( { model | post = Just postData }, Cmd.none )

        GetPostById idString ->
            let
                id =
                    String.toInt idString |> Result.withDefault 1
            in
                ( { model | post = Nothing, requestedId = id }, getPost id )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view { post, requestedId } =
    let
        status =
            case post of
                Nothing ->
                    "loading"

                Just (Err error) ->
                    "Error" ++ (toString error)

                Just (Ok { id, title }) ->
                    (toString id) ++ " - " ++ title
    in
        div []
            [ input
                [ onInput GetPostById
                , value (toString requestedId)
                , placeholder "Post Id"
                ]
                []
            , br [] []
            , text status
            ]
