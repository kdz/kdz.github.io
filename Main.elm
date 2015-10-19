{- 
    -- NOT USED
    -- Could provide container for Menu + (Resume | Code | ...) 

module Main where

import ResumeView as RV
import Menu
import Signal exposing (Address)
import Html exposing (..)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp

-- ------- MODEL

type alias Model = { resume : RV.Model, selection : Action }

init : Model
init = { resume = RV.init, selection = Resume }

-- ------- UPDATE

type Action = Resume | Code | RV RV.Action

update : Action -> Model -> Model
update a m =
  case a of
    Resume -> { m | selection <- a }
    Code -> { m | selection <- a }
    RV _ -> m

-- ------- VIEW

view :  Address Action -> Model -> Html
view addr model =
  div [id "layout"] [
    RV.purecss,
    Menu.leftMenu,
    RV.view (Signal.forwardTo addr RV) model.resume
  ]


-- ------- main

main : Signal Html
main =
  StartApp.start
    { model = init
    , update = update
    , view = view
    }

-}
