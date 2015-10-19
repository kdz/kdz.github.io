{- 
    -- Not currently used. 
    -- Could provide a Code view (just demos & repos) 

import Html exposing (..)
import Html.Attributes exposing (..)
import ResumeData as RD
import ResumeView as RV
import Signal exposing (Address)

type alias Model = RD.Resume

demos : Model -> List RD.Item
demos model = 
  List.filter 
    (\item -> (item.demo /= Nothing) || (item.repo /= Nothing))
    model.projects

type alias Action = RV.Action

view : Address Action -> Model -> Html
view addr model = 
  div [] [
    RV.purecss,
    RV.localcss,
    RV.printcss,

    RV.viewHeader model.header,

    section [id "demos_repos"] (
      h2 [class "sectionHeader"] [text "Demos and Repos"]
      ::
      RV.viewItemList addr RV.NoOp (RV.expandoList (demos model))
    )

  ]


mb = Signal.mailbox (RV.NoOp 0)

main = view mb.address RD.kelseyResume

-}
