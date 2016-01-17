module HomePage where

import Resume
import Menu
import Demos
import Signal exposing (Address, forwardTo)
import Html exposing (..)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp

-- ----- MODEL

type Mode = CV | Demos | Blog | About

menu : List (String, Mode)
menu = [("Resume", CV), ("Demos and Source", Demos), ("Blog", Blog), ("About", About)]

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
    MenuAct a -> { model | mode = Menu.update a } 

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
        Blog -> 
          div [] [
            Resume.viewHeader model.resume.header,
            section [id "blog_repos"] [
              h2 [class "sectionHeader"] [text "Blog"],
              h4 [class "itemName"] [ text "Someday I will find the time to blog ... " ]
            ]
          ]
        About -> div [] [
          div [] [
            Resume.viewHeader model.resume.header,
            section [id "about"] [
              h2 [class "sectionHeader"] [text "About"],
              h4 [class "itemName"] [ 
                text "This site is written in ",
                a [href "http://www.elm-lang.org", target "_blank"] [text "Elm"],
                text ". Here is the ",
                a [href "http://www.github.com/kdz/kdz.github.io.git", target "_blank"] [text "repo."]
              ]
            ]
          ]
        ]
      ]
    ]

main : Signal Html
main = 
  StartApp.start
    { model = init
    , update = update
    , view = view
    }
