module HomePage exposing (..)

import Resume
import Menu
import Demos
import Html exposing (..)
import Html.Attributes exposing (..)


-- ----- MODEL


type Mode
    = CV
    | Demos
    | Blog
    | About


menu : List ( String, Mode )
menu =
    [ ( "Resume", CV ), ( "Demos & More", Demos ), ( "Blog", Blog ), ( "About", About ) ]


type alias Model =
    { mode : Mode
    , resume : Resume.Model
    }


init : ( Model, Cmd Msg )
init =
    ( { mode = CV, resume = Resume.init }, Cmd.none )



-- ------ UPDATE ----


type Msg
    = MenuAct (Menu.Msg Mode)
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update act model =
    case act of
        NoOp ->
            ( model, Cmd.none )

        MenuAct a ->
            ( { model | mode = Menu.update a }, Cmd.none )



-- ------ VIEW ----


view : Model -> Html Msg
view model =
    div
        []
        [ Resume.purecss
        , Resume.localcss
        , Resume.printMediaCss
        , div
            [ id "layout" ]
            [ Html.map MenuAct (Menu.view menu model.mode)
            , case model.mode of
                CV ->
                    Resume.view model.resume

                Demos ->
                    Demos.view model.resume

                Blog ->
                    div
                        []
                        [ Resume.viewHeader model.resume.header
                        , section
                            [ id "blog_repos" ]
                            [ hr [] []
                            , h2 [ class "sectionHeader" ] [ text "Blog" ]
                            , h4 [ class "itemName" ] [ text "Someday I will find the time to blog ... " ]
                            ]
                        ]

                About ->
                    div
                        []
                        [ div
                            []
                            [ Resume.viewHeader model.resume.header
                            , section
                                [ id "about" ]
                                [ hr [] []
                                , h2 [ class "sectionHeader" ] [ text "About" ]
                                , h4
                                    [ class "itemName" ]
                                    [ text "This site is written entirely in "
                                    , a [ href "http://www.elm-lang.org", target "_blank" ] [ text "Elm" ]
                                    , text ". Here is the "
                                    , a [ href "http://www.github.com/kdz/kdz.github.io.git", target "_blank" ] [ text "repo." ]
                                    ]
                                ]
                            ]
                        ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
