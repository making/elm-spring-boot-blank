module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { greeting : Greeting
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { greeting = { id = 0, content = "" } }
    , Cmd.none
    )


type Msg
    = Click
    | GotGreeting (Result Http.Error Greeting)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ( model
            , Http.get
                { url = "/greeting"
                , expect = Http.expectJson GotGreeting greetingDecoder
                }
            )

        GotGreeting (Ok greeting) ->
            ( { model | greeting = greeting }, Cmd.none )

        GotGreeting (Err error) ->
            ( { model | greeting = { id = -1, content = Debug.toString error } }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Click ] [ text "Greet" ]
        , table []
            [ tr []
                [ th [] [ text "ID" ]
                , td [] [ text (String.fromInt model.greeting.id) ]
                ]
            , tr []
                [ th [] [ text "Content" ]
                , td [] [ text model.greeting.content ]
                ]
            ]
        ]


type alias Greeting =
    { id : Int
    , content : String
    }


greetingDecoder : Decoder Greeting
greetingDecoder =
    Json.Decode.map2 Greeting
        (Json.Decode.field "id" Json.Decode.int)
        (Json.Decode.field "content" Json.Decode.string)
