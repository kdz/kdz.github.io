module Resume where

import ResumeData as RD
import Html exposing (..)
import Html.Attributes exposing (..)
import Basics exposing (toString)

-- ------ MODEL ----

type alias Expando = (RD.Item, Bool)

type alias Model = {
  header : RD.Header,
  education : List Expando,
  work : List Expando,
  projects : List Expando,
  publications : List Expando,
  activities : List RD.Activity,
  skills : List RD.Skill,
  traits : List RD.Trait
}

expandoList : List RD.Item -> List Expando
expandoList list = List.map (\i -> (i, False)) list

init : Model
init = 
  let r = RD.kelseyResume in
  { header = r.header,
    education = expandoList r.education,
    work = expandoList r.work,
    projects = expandoList r.projects,
    publications = expandoList r.publications,
    activities = r.activities,
    skills = r.skills,
    traits = r.traits
  }


viewItem : Expando -> Html
viewItem ({name, role, location, dates, details}, expanded) = 
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

model = init

main : Html
main = 
  let 
    listing : List a -> Html
    listing list = 
      ul [] (List.map (\x -> li [] [text (toString x)]) list)

    items : List Expando -> List Html
    items list =
      List.map viewItem list
  in
  div [id "layout"] [
    node "link" [rel "stylesheet", type' "text/css", href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css"] [],
    node "link" [rel "stylesheet", type' "text/css", href "css/style.css"] [],

    --node "style" [type' "text/css"] [text "@import 'css/print-style.css' print;"],

    --leftMenu, 

    viewHeader model.header,

    section [id "education"] (
      h2 [class "sectionHeader"] [text "Education"]
      ::
      items model.education
    ),
    
    section [id "work"] (
      h2 [class "sectionHeader"] [text "Work Experience"]
      ::
      items model.work
    ),

    section [id "projects"] (
      h2 [class "sectionHeader"] [text "Project Experience"]
      ::
      items model.projects
    ),

    section [id "publications"] (
      h2 [class "sectionHeader"] [text "Publications"]
      ::
      items model.publications
    ),

    section [id "activities"] [
      h2 [class "sectionHeader"] [text "Activities"],
      ul [] 
        (List.map 
          (\ { name, role, dates } -> 
            li [class "split-l-r"] [
              span [class "left"] [text name, text ", ", text role],
              span [class "right"] [text dates]
            ])
          model.activities
        )
    ],

    section [id "skills"] [
      h2 [class "sectionHeader"] [text "Skills"],
      div [class "bulletSep"]
        (List.map 
          (\ { name, level } -> span [] [bullet, text name, text ": ", text level])
          model.skills
        )
    ],

    section [id "traits"] [
      h2 [class "sectionHeader"] [text "Traits"],
      div [class "bulletSep"]
        (List.map 
          (\trait -> span [] [bullet, text trait])
          model.traits
        )
    ]
  ]