module Menu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- ------- MODEL ----
-- None: no state is owned or updated by menu
-- All context is passed to view by parent, and to update as Action
-- ------- UPDATE ----

type Action a
    = Select a

-- The return value is like an Event that parent can handle

update : Action a -> a
update (Select a) =
    a

-- ------- VIEW ----

view : List ( String, a ) -> a -> Html (Action a)
view choices sel =
    let
        itemClass val selVal =
            if val /= selVal then
                "pure-menu-item"
            else
                "pure-menu-item pure-menu-selected"
    in
        div
            [ id "menu" ]
            [ div
                [ class "pure-menu" ]
                [ span [ class "pure-menu-heading" ] [ text "Choose" ]
                , ul
                    [ class "pure-menu-list" ]
                    (List.map
                        (\( str, val ) ->
                            li
                                [ class (itemClass val sel)
                                , onClick (Select val)
                                ]
                                [ text str ]
                        )
                        choices
                    )
                ]
            ]



--}
