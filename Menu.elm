module Menu where

-- Takes any type 'a' in choices : List (String, a)
-- Sets up a UI-callback of (Select a) for each choice
-- Returns the selected 'a' on update
-- So the Action type is parameterized by 'a'

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)

-- ------- MODEL ----
-- None: no state is owned or updated by menu
-- All context is passed to view by parent, and to update as Action

-- ------- UPDATE ----

type Action a = Select a

-- The return value is like an Event that parent can handle
update : Action a -> a
update (Select a) = a

-- ------- VIEW ----

view : Address (Action a) -> List (String, a) -> a -> Html
view addr choices sel = 
  let itemClass val selVal = if val/=selVal
                                    then "pure-menu-item" 
                                    else "pure-menu-item pure-menu-selected"
  in
  div [id "menu"] [ 
    div [class "pure-menu"] [ 
      span [class "pure-menu-heading"] [text "Choose"],
      ul [class "pure-menu-list"]
        (List.map 
          (\(str, val) -> li  [ class (itemClass val sel), 
                                onClick addr (Select val)] 
                            [text str])
          choices)
      ]
    ]


--}
