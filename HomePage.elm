module HomePage where

import Resume
import Menu
import Demos
import Signal exposing (Address, forwardTo)
import Html exposing (..)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp


-- ----- MODEL

type Mode = CV | Demos | Blog

menu : List (String, Mode)
menu = [("Resume", CV), ("Demos and Source", Demos), ("Blog", Blog)]

type alias Model = {
  mode : Mode,
  resume : Resume.Model
 }

init : Model
init = { mode = CV, resume = Resume.init }

-- ------ UPDATE ----

type Action 
  = MenuAct (Menu.Action Mode)
  | NoOp

update : Action -> Model -> Model
update act model =
  case act of
    NoOp -> model
    MenuAct a -> { model | mode <- Menu.update a } 

-- ------ VIEW ----

view : Address Action -> Model -> Html
view addr model = 
  let 
    fwd : Address (Menu.Action Mode)
    fwd = Signal.forwardTo addr MenuAct
  in
  div [] [

    Resume.purecss,
    Resume.localcss,
    Resume.printcss,
    Resume.printmediaCss,

    div [id "layout"] [
      Menu.view fwd menu model.mode,
      case model.mode of
        CV -> Resume.view model.resume
        Demos -> Demos.view model.resume
        Blog -> div [] [text "Someday I will have the time to blog ... "]
    ]
  ]

main : Signal Html
main = 
  StartApp.start
    { model = init
    , update = update
    , view = view
    }
