module Demos exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Resume as Res

type alias Model = Res.Model

demos : Model -> List Res.Item
demos model =
  List.filter
    (\item -> (item.demo /= Nothing) || (item.repo /= Nothing))
    model.projects

view : Model -> Html a
view model =
  div [] [

    Res.viewHeader model.header,

    section [id "demos_repos"] (
      h2 [class "sectionHeader"] [text "Demos and Repos"]
      ::
      List.map Res.viewItem (demos model)
    )

  ]
