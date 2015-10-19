{-  
    -- Not currently used. 
    -- Could provide left menu bar like http://purecss.io/  

module Menu where

import Html exposing (..)
import Html.Attributes exposing (..)

leftMenu : Html
leftMenu = 
  div [id "menu"] [ 
    div [class "pure-menu"] [ 
      span [class "pure-menu-heading"] [text "Choose"],
      ul [class "pure-menu-list"] [ 
        li [class "pure-menu-item"] [text "Resume"],
        li [class "pure-menu-item"] [text "Demos"],
        li [class "pure-menu-item"] [text "Repos"]
      ]
    ]
  ]

-}
