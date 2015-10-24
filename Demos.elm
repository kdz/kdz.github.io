module Demos where

import Html exposing (..)
import Html.Attributes exposing (..)
import Resume as Res

type alias Model = Res.Model

demos : Model -> List Res.Item
demos model = 
  List.filter 
    (\item -> (item.demo /= Nothing) || (item.repo /= Nothing))
    model.projects

view : Model -> Html
view model = 
  div [] [

    Res.viewHeader model.header,

    section [id "demos_repos"] (
      h2 [class "sectionHeader"] [text "Demos and Repos"]
      ::
      List.map Res.viewItem (demos model)
    )

  ]


--mb = Signal.mailbox (RV.NoOp 0)

--main = view mb.address RD.kelseyResume

--}
