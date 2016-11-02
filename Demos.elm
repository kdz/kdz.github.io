module Demos exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Resume
import ResumeData


demos : Resume.Model -> List Resume.Item
demos resume =
    let
        demoable list =
            List.filter
                (\item ->
                    (item.demo /= Nothing)
                        || (item.repo /= Nothing)
                        || (item.more /= Nothing)
                )
                list

        demoItems section =
            case section of
                ResumeData.NestedSection _ items ->
                    demoable items

                ResumeData.FlatSection _ _ ->
                    []

                ResumeData.InlineSection _ _ ->
                    []
    in
        List.concatMap demoItems resume.body


view : Resume.Model -> Html a
view model =
    div []
        [ Resume.viewHeader model.header
        , section [ id "demos_repos" ]
            (h2 [ class "sectionHeader" ] [ text "Demos, Repos, More" ]
                :: List.map Resume.viewItem (demos model)
            )
        ]
