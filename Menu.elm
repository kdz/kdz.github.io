module Menu where

leftMenu : Html
leftMenu = 
  div [id "menu"] [ 
    div [class "pure-menu"] [ 
      span [class "pure-menu-heading"] [text "Browse..."],
      ul [class "pure-menu-list"] [ 
        li [class "pure-menu-item"] [text "Resume"],
        li [class "pure-menu-item"] [text "Demos"],
        li [class "pure-menu-item"] [text "Repos"]
      ]
    ]
  ]
