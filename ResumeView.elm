module Resume where

import ResumeModel as M
import Html exposing (..)
import Html.Attributes exposing (..)
import Basics exposing (toString)

leftMenu : Html
leftMenu = 
  div [id "menu"] 
    [ div [class "pure-menu"]
      [ span [class "pure-menu-heading"] [text "Browse..."],
        ul [class "pure-menu-list"]
          [ li [class "pure-menu-item"] [text "Resume"],
            li [class "pure-menu-item"] [text "Demos"],
            li [class "pure-menu-item"] [text "Repos"]
          ]
      ]
    ]

viewItem : M.Item -> Html
viewItem {name, role, location, dates, details} = 
  div [class "item"] [
    div [class "itemLeft"] [
      h3 [class "itemName"] [text name],
      ul [class "itemDetails"] (List.map (\x -> li [] [text x]) details)
    ],
    div [class "itemAttrs"] [
      div [class "itemDates"] [text dates],
      div [class "itemRole"] [text role],
      div [class "itemLocation"] [text location]
    ]
  ]

bullet = span [class "bullet"] []


viewHeader header = 
  section [id "header"] [
    div [id "namePhoto"] [
      --img [src header.photo, id "photo"] [],
      div [id "nameAffil"] (
        h1 [class "myName"] [text header.name]
        ::
        (List.map 
          (\affil -> div [class "affil"] [text affil])
          header.affils)
      )
    ],
    div [class "myContactInfo"] [
      div [] [  text header.home ],
      div [] [  text header.email, bullet, 
                text header.phone ],
      div [id "urls"] [
        a [href header.homepage] [text header.homepage], bullet,
        a [href header.github] [text header.github], bullet,
        a [href header.linkedin] [text header.linkedin]
      ]
    ]
  ]

main : Html
main = 
  let 
    listing : List a -> Html
    listing list = 
      ul [] (List.map (\x -> li [] [text (toString x)]) list)

    items : List M.Item -> List Html
    items list =
      List.map viewItem list
  in
  div [id "layout"] [
    node "link" [rel "stylesheet", type' "text/css", href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css"] [],
    node "link" [rel "stylesheet", type' "text/css", href "css/style.css"] [],

    --node "style" [type' "text/css"] [text "@import 'css/print-style.css' print;"],

    --leftMenu, 

    viewHeader M.header,

    section [id "education"] (
      h2 [class "sectionHeader"] [text "Education"]
      ::
      items M.education
    ),
    
    section [id "work"] (
      h2 [class "sectionHeader"] [text "Work Experience"]
      ::
      items M.work
    ),

    section [id "projects"] (
      h2 [class "sectionHeader"] [text "Project Experience"]
      ::
      items M.projects
    ),

    section [id "publications"] (
      h2 [class "sectionHeader"] [text "Publications"]
      ::
      items M.publications
    ),

    section [id "activities"] [
      h2 [class "sectionHeader"] [text "Activities"],
      ul [] 
        (List.map 
          (\(act, r, d) -> 
            li [class "split-l-r"] [
              span [class "left"] [text act, text ", ", text r],
              span [class "right"] [text d]
            ])
          M.activities
        )
    ],

    section [id "skills"] [
      h2 [class "sectionHeader"] [text "Skills"],
      div [class "bulletSep"]
        (List.map 
          (\ (subj, level) -> span [] [bullet, text subj, text ": ", text level])
          M.skills
        )
    ],

    section [id "traits"] [
      h2 [class "sectionHeader"] [text "Traits"],
      div [class "bulletSep"]
        (List.map 
          (\trait -> span [] [bullet, text trait])
          M.traits
        )
    ]
  ]