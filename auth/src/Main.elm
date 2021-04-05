module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { username : String
    , password : String
    }


init : Model
init =
    Model "" ""



-- Update


type Msg
    = Username String
    | Password String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Username username ->
            { model | username = username }

        Password password ->
            { model | password = password }



-- View


withStyle : Html msg -> Html msg
withStyle html =
    div []
        [ node "style"
            [ type_ "text/css" ]
            [ text "@import url(https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css)" ]
        , html
        ]


view : Model -> Html Msg
view model =
    div [ class "columns is-centered mt-6" ]
        [ div [ class "column is-narrow" ]
            [ h1 [ class "title is-1" ] [ text "Login" ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ input [ type_ "text", class "input", placeholder "username", value model.username, onInput Username ] []
                    ]
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ input [ type_ "password", class "input", placeholder "password", value model.password, onInput Password ] []
                    ]
                ]
            , button [ type_ "submit", class "button is-primary" ] [ text "Submit" ]
            , p [] [ text model.username ]
            ]
        ]
        |> withStyle
