module Resume where

import ResumeData exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import String

-- ------ MODEL ----

type alias Model = Resume 
type alias Item = ResumeData.Item

init : Resume
init = ResumeData.kelseyResume

-- ----- VIEW ---

nullHtml : Html
nullHtml = node "noscript" [] []

viewItem : Item -> Html
viewItem item = 
  let {name, role, location, dates, details, more, repo, demo} = item 
      srcLink = case repo of
              Nothing -> nullHtml
              Just s -> a [ class "link", href s, target "_blank" ] [text "repo"]
      demoLink = case demo of
              Nothing -> nullHtml
              Just s -> a [class "link", href s, target "_blank"] [text "demo"]
  in
  div [class "item"] [
    div [class "itemLeft"] [
      h3 [class "itemName"] [
        text name,
        span [] [ srcLink, demoLink ]
      ],
      ul [class "itemDetails"] (List.map (\x -> li [class "detail"] [text x]) details)
    ],
    div [class "itemAttrs"] [
      div [class "itemDates"] [text dates],
      div [class "itemRole"] [text role],
      div [class "itemLocation"] [text location]
    ]
  ]

bullet : Html
bullet = span [class "bullet"] []

viewHeader : Header -> Html
viewHeader header = 
  let short url = String.dropLeft 8 url 
  in
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
      div [] [  bullet, text header.email, 
                bullet, text header.phone ],
      div [id "urls"] [
        bullet, text "Home", a [href header.homepage, target "_blank"] [text (short header.homepage)],
        bullet, text "Github", a [href header.github, target "_blank"] [text (short header.github)],
        bullet, text "LinkedIn", a [href header.linkedin, target "_blank"] [text (short header.linkedin)]
      ]
    ]
  ]

purecss : Html
purecss = 
  node "link" [rel "stylesheet", type' "text/css", href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css"] []

localcss : Html
localcss =   
  node "link" [rel "stylesheet", type' "text/css", href "css/style.css"] []

printcss : Html
printcss = 
  node "style" [type' "text/css"] [text "@import 'css/print-style.css';"]

printmediaCss : Html
printmediaCss = 
  node "style" [type' "text/css"] [
    text "@media print {
            .link { display: none; }
          }" ]


view : Model -> Html
view model = 
  div [] [

    purecss,
    localcss,
    printcss,
    printmediaCss,

    viewHeader model.header,

    section [id "education"] (
      h2 [class "sectionHeader"] [text "Education"]
      ::
      List.map viewItem model.education
    ),
    
    section [id "work"] (
      h2 [class "sectionHeader"] [text "Work Experience"]
      ::
      List.map viewItem model.work
    ),

    section [id "projects"] (
      h2 [class "sectionHeader"] [text "Project Experience"]
      ::
      List.map viewItem model.projects
    ),

    section [id "publications"] (
      h2 [class "sectionHeader"] [text "Publications"]
      ::
      List.map viewItem model.publications
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
      div [class "bulletSepList"]
        (List.map 
          (\ { name, level } -> span [] [bullet, text name, text ": ", text level])
          model.skills
        )
    ],

    section [id "traits"] [
      h2 [class "sectionHeader"] [text "Traits"],
      div [class "bulletSepList"]
        (List.map 
          (\trait -> span [] [bullet, text trait])
          model.traits
        )
    ]
  ]

-- ------- MAIN

main : Html
main = view kelseyResume
