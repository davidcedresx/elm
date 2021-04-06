module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type Auth
    = Authenticated
    | Guest { username : String, password : String }


type alias Model =
    Auth


init : Model
init =
    Guest { username = "", password = "" }



-- Update


type Msg
    = Username String
    | Password String
    | Logged


update : Msg -> Model -> Model
update msg model =
    case ( msg, model ) of
        ( Username username, Guest guest ) ->
            Guest { guest | username = username }

        ( Password password, Guest guest ) ->
            Guest { guest | password = password }

        ( Logged, _ ) ->
            Authenticated

        _ ->
            model



-- View


withStyle : Html msg -> Html msg
withStyle html =
    div []
        [ node "style"
            [ type_ "text/css" ]
            [ text "@import url(https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css)" ]
        , html
        ]

withLayout : Html msg -> Html msg
withLayout html =
    div [class "container"] 
    [
        html
    ]
    |> withStyle


view : Model -> Html Msg
view model =
    case model of
        Guest guest ->
            div [ class "columns mt-6" ]
                [ div [ class "column is-narrow" ]
                    [ h1 [ class "title is-1" ] [ text "Login" ]
                    , div [ class "field" ]
                        [ div [ class "control" ]
                            [ input [ type_ "text", class "input", placeholder "username", value guest.username, onInput Username ] []
                            ]
                        ]
                    , div [ class "field" ]
                        [ div [ class "control" ]
                            [ input [ type_ "password", class "input", placeholder "password", value guest.password, onInput Password ] []
                            ]
                        ]
                    , button [ type_ "submit", class "button is-primary", onClick Logged ] [ text "Submit" ]
                    ]
                ]
                |> withLayout
        Authenticated ->
            h1 [ class "title is-1"] [ text "Welcome!"] |> withLayout
