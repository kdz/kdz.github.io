module Resume exposing (..)

import ResumeData exposing (Resume, Header, FlatItem, Section(..), theResume)
import Html exposing (..)
import Html.Attributes exposing (..)
import String


-- ------ MODEL ----


type alias Model =
    Resume


type alias Item =
    ResumeData.Item


init : Resume
init =
    ResumeData.theResume



-- ----- VIEW ---


nullHtml : Html a
nullHtml =
    node "noscript" [] []


viewItem : Item -> Html a
viewItem item =
    let
        { name, role, location, dates, details, more, repo, demo } =
            item

        linkFor name url =
            case url of
                Nothing ->
                    nullHtml

                Just s ->
                    a [ class "link", href s, target "_blank" ] [ text name ]

        srcLink =
            linkFor "repo" repo

        demoLink =
            linkFor "demo" demo

        moreLink =
            linkFor "more" more
    in
        div [ class "item" ]
            [ div [ class "itemLeft" ]
                [ h3 [ class "itemName" ]
                    [ text name
                    , span [ class "itemRole" ] [ text role ]
                    , span [] [ srcLink, demoLink, moreLink ]
                    ]
                , ul [ class "itemDetails" ]
                    (List.map (\x -> li [ class "detail" ] [ text x ]) details)
                ]
            , div [ class "itemAttrs" ]
                [ div [ class "itemLocation" ] [ text location ]
                , div [ class "itemDates" ] [ text dates ]
                  -- , div [ class "itemRole" ] [ text role ]
                ]
            ]


bullet : Html a
bullet =
    span [ class "bullet" ] []


viewHeader : Header -> Html a
viewHeader header =
    let
        short url =
            String.dropLeft 8 url
    in
        section [ id "header" ]
            [ div [ id "namePhoto" ]
                [ div [ id "nameAffil" ]
                    (h1 [ class "myName" ] [ text header.name ]
                        :: (List.map
                                (\affil -> div [ class "affil" ] [ text affil ])
                                header.affils
                           )
                    )
                ]
            , div [ class "myContactInfo" ]
                [ div []
                    [ bullet
                    , text header.email
                    , bullet
                    , text header.phone
                    ]
                , div [ id "urls" ]
                    (List.concatMap
                        (\{ name, url } ->
                            [ bullet
                            , text name
                            , a [ href url, target "_blank" ] [ text (short url) ]
                            ]
                        )
                        header.links
                    )
                ]
            ]


purecss : Html a
purecss =
    node "link" [ rel "stylesheet", type' "text/css", href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css" ] []


localcss : Html a
localcss =
    node "link" [ rel "stylesheet", type' "text/css", href "css/style.css" ] []


printcss : Html a
printcss =
    node "style" [ type' "text/css" ] [ text "@import 'css/print-style.css';" ]


printmediaCss : Html a
printmediaCss =
    node "style"
        [ type' "text/css" ]
        [ text "@media print {\n            .link { display: none; }\n   hr { display: none}\n       }"
        ]


viewNestedItems : List Item -> List (Html a)
viewNestedItems items =
    List.map viewItem items


viewFlatItems : List FlatItem -> List (Html a)
viewFlatItems items =
    [ ul []
        (List.map
            (\{ name, attrs } ->
                li [ class "split-l-r" ]
                    [ span [ class "left" ] [ text name ]
                    , span [ class "right" ] [ text attrs ]
                    ]
            )
            items
        )
    ]


viewInlineItems : List String -> List (Html a)
viewInlineItems items =
    [ div [ class "bulletSepList" ]
        (List.map
            (\item -> span [] [ bullet, text item ])
            items
        )
    ]


viewSection : Section -> Html a
viewSection s =
    let
        name =
            case s of
                NestedSection n _ ->
                    n

                FlatSection n _ ->
                    n

                InlineSection n _ ->
                    n
    in
        section []
            (hr [] []
                :: h2 [ class "sectionHeader" ] [ text name ]
                :: (case s of
                        NestedSection _ items ->
                            viewNestedItems items

                        FlatSection _ items ->
                            viewFlatItems items

                        InlineSection _ items ->
                            viewInlineItems items
                   )
            )


view : Model -> Html a
view model =
    div []
        ([ purecss
         , localcss
         , printcss
         , printmediaCss
         , viewHeader model.header
         ]
            ++ List.map viewSection model.body
        )



-- ------- MAIN


main : Html a
main =
    view theResume
