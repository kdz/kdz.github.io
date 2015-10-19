module ResumeView where

import ResumeData as RD
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Basics exposing (toString)
import Signal exposing (Signal, Address)
import StartApp.Simple as StartApp
import Debug

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

-- UPDATE

type Action
    = ToggleEducation Int
    | ToggleWork Int
    | ToggleProject Int
    | TogglePub Int
    | NoOp Int

toggleExpando : Action -> Model -> Model
toggleExpando action model =
  let toggle_i i list = case list of 
        [] -> []
        (item, expanded) :: rest -> 
          if i==0 
            then (item, (not expanded)) :: rest
            else (item, expanded) :: (toggle_i (i-1) rest)
      _ = Debug.log "Update" action
  in
  case action of
    ToggleEducation i -> { model | education <- toggle_i i model.education }
    ToggleWork i -> { model | work <- toggle_i i model.work }
    ToggleProject i -> { model | projects <- toggle_i i model.projects }
    TogglePub i -> { model | publications <- toggle_i i model.publications }


-- ----- VIEW ---

nullHtml : Html
nullHtml = node "noscript" [] []

viewItem : Address Action -> Action -> Expando -> Html
viewItem addr callback (item, expanded) = 
  let {name, role, location, dates, details, more, repo, demo} = item 
      prompt = if expanded then "Less" else "More"
      hasMore = not (more==Nothing) -- && repo==Nothing && demo==Nothing)
      toggler = if False -- hasMore
        then a  [ class "more-less link", onClick addr callback, href "javascript:void(0)"]
                [ text prompt]
        else nullHtml
      shownMore = if False -- expanded && hasMore
        then div [class "more"] [text (toString more)]
        else nullHtml
      srcLink = case repo of
              Nothing -> nullHtml
              Just s -> a [ class "link", href s ] [text "source"]
      demoLink = case demo of
              Nothing -> nullHtml
              Just s -> a [class "link", href s] [text "demo"]
  in
  div [class "item"] [
    div [class "itemLeft"] [
      h3 [class "itemName"] [
        text name,
        span [] [ toggler,
                  srcLink,
                  demoLink  ]
      ],
      ul [class "itemDetails"] (List.map (\x -> li [class "detail"] [text x]) details),
      shownMore
    ],
    div [class "itemAttrs"] [
      div [class "itemDates"] [text dates],
      div [class "itemRole"] [text role],
      div [class "itemLocation"] [text location]
    ]
  ]

viewItemList : Address Action -> (Int -> Action) -> List Expando -> List Html
viewItemList addr tagger list =
  List.indexedMap 
    (\i expando -> viewItem addr (tagger i) expando)
    list

bullet : Html
bullet = span [class "bullet"] []

viewHeader : RD.Header -> Html
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

purecss = 
  node "link" [rel "stylesheet", type' "text/css", href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css"] []

localcss =   
  node "link" [rel "stylesheet", type' "text/css", href "css/style.css"] []

printcss = 
  node "style" [type' "text/css"] [text "@import 'css/print-style.css';"]

printmediaCss = 
  node "style" [type' "text/css"] [
    text "@media print {
            .link { display: none; }
          }" ]


view : Address Action -> Model -> Html
view addr model = 
  div [] [

    purecss,
    localcss,
    printcss,
    printmediaCss,

    viewHeader model.header,

    section [id "education"] (
      h2 [class "sectionHeader"] [text "Education"]
      ::
      viewItemList addr ToggleEducation model.education
    ),
    
    section [id "work"] (
      h2 [class "sectionHeader"] [text "Work Experience"]
      ::
      viewItemList addr ToggleWork model.work
    ),

    section [id "projects"] (
      h2 [class "sectionHeader"] [text "Project Experience"]
      ::
      viewItemList addr ToggleProject model.projects
    ),

    section [id "publications"] (
      h2 [class "sectionHeader"] [text "Publications"]
      ::
      viewItemList addr TogglePub model.publications
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

-- ------- main

main : Signal Html
main =
  StartApp.start
    { model = init
    , update = toggleExpando
    , view = view
    }
