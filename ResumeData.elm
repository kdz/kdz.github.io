module ResumeData
    exposing
        ( theResume
        , Resume
        , Header
        , Item
        , Section(..)
        , FlatItem
        )


type alias Resume =
    { header : Header
    , body : List Section
    }


type alias Header =
    { name : String
    , affils : List String
    , home : String
    , email : String
    , phone : String
    , links : List { name : String, url : Url }
    }


type Section
    = NestedSection String (List Item)
    | FlatSection String (List FlatItem)
    | InlineSection String (List String)


type alias Item =
    { name : String
    , details : List String
    , location : String
    , dates : String
    , role : String
    , dates : String
    , more : Maybe Url
    , repo : Maybe Url
    , demo : Maybe Url
    }


type alias Url =
    String


type alias FlatItem =
    { name : String, attrs : String }



-- ----- DATA ---


theResume : Resume
theResume =
    { header = header
    , body =
        [ NestedSection "Education" education
        , InlineSection "Programming Languages" programming
        , NestedSection "Publications & Awards" awards
        , NestedSection "Work Experience" work
        , NestedSection "Project Experience" projects
        , FlatSection "Activities" activities
        , InlineSection "Personal Traits" traits
        ]
    }


header : Header
header =
    { name = "Kelsey D'Souza"
    , affils = []
    , home = "9901 Spicewood Mesa, Austin, TX 78759"
    , email = "kad2185@columbia.edu"
    , phone = "512-363-9556"
    , links =
        [ { name = "Home page:", url = "https://github.com/kdz" }
        , { name = "Github:", url = "https://kdz.github.io" }
        , { name = "LinkedIn:", url = "https://goo.gl/xcSDtb" }
        ]
    }


education : List Item
education =
    [ { name = "Columbia University, School of Engineering and Applied Science"
      , location = "New York, NY"
      , dates = "Expected May 2018"
      , role = ""
      , details =
            [ "BS in Computer Science / Intelligent Systems, Minor in Applied Math"
            , "Cumulative GPA: 3.6, Major GPA: 3.7"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    ]


programming : List String
programming =
    [ "Highly proficient: Python, Elm"
    , "Proficient: Java, Javascript, Ocaml, HTML"
    , "Basic usage: C, C++, SQL, Matlab"
    ]


awards : List Item
awards =
    [ { name = "Delphix Technology Scholarship for Women"
      , role = ""
      , location = "Menlo Park, CA"
      , dates = "December 2015"
      , details =
            [ "Winner of Delphix 2015 Annual Technology Scholarship for Women (for EboHub project)"
            ]
      , more = Just "http://goo.gl/UFN80c"
      , repo = Nothing
      , demo = Nothing
      }
    , { name = "PySTEMM: Executable Concept Modeling for K-12 Learning"
      , role = "Sole author"
      , location = "Brussels, Belgium"
      , dates = "August 2013"
      , details =
            [ "Proceedings of the 6th European Conference on Python in Science (EuroSciPy 2013)"
            , "Independently developed Python-based concept modeling tool to assist STEM learning"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    ]


work : List Item
work =
    [ { name = "Google"
      , role = "Engineering Practicum Intern"
      , location = "New York, NY"
      , dates = "Summer 2016"
      , details =
            [ "Worked with Core and Cloud team on streamlined collaborative version control and testing system"
            , "Developed desktop and browser app for the system from scratch in Elm (FP) and Javascript"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    , { name = "Columbia University, Computation in Python: COMS1006"
      , role = "Teaching Assistant"
      , location = "New York, NY"
      , dates = "Fall 2015 - present"
      , details =
            [ "Weekly office-hours, guide recitations, design problem sets, under Dr. Adam Cannon"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    , { name = "Columbia University, Dicrete Mathematics: COMS3203"
      , role = "Teaching Assistant"
      , location = "New York, NY"
      , dates = "Spring 2016"
      , details =
            [ "Weekly office hours, debug program submissions, and guide recitations under Dr. Salleb-Aouissi"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    , { name = "Enthought Scientific Computing"
      , role = "Software summer intern"
      , location = "Austin, TX"
      , dates = "Summer 2015"
      , details =
            [ "Developed interactive data visualizer for Canopy data-analysis platform (MatPlotLib, Pandas, Seaborn)"
            , "Worked in large live GitHub repository on individual feature branch and opened bug fix branches"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
      -- , { name = "UT Austin Iyer Lab, Functional Genomics"
      --   , role = "Research Intern"
      --   , location = "Austin, TX"
      --   , dates = "Summer 2014"
      --   , details =
      --         [ "Assisted Dr. Gregory Hatlestad in researching coloration enzymes in plant DNA"
      --         , "Performed PCR, gel electrophoresis, bacterial transformations and DNA analysis"
      --         ]
      --   , more = Nothing
      --   , repo = Nothing
      --   , demo = Nothing
      --   }
    ]


projects : List Item
projects =
    [ { name = "Assembly Language Simulator in Elm"
      , role = "Sole Developer"
      , location = "New York, NY"
      , dates = "Fall 2015"
      , details =
            [ "A single-page Elm application for an interactive Assembly Language Simulator"
            ]
      , more = Nothing
      , repo = Just "http://github.com/kdz/elmassembly"
      , demo = Just "http://kdz.github.io/demos/elmassembly/build/Main.html"
      }
    , { name = "Executable domain models"
      , role = "Personal Project"
      , location = "New York, NY"
      , dates = "Fall 2015"
      , details =
            [ "Model and simulate course concepts using Elm to solidify understanding"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    , { name = "EboHub: Ebola/Infectious Disease Surveillance System"
      , role = "Sole Developer"
      , location = "New York, NY"
      , dates = "2014 - 2015"
      , details =
            [ "Led team of 5, built system for mobile healthcare workers doing disease surveillance"
            , "Used Python/Postgresql web service with 2-way SMS-based mobile and web interfaces"
            , "Columbia Ebola Design Challenge finalist, worked with There Is No Limit Foundation in Guinea"
            ]
      , more = Nothing
      , repo = Just "http://github.com/kdz/ebohub"
      , demo = Just "http://ebohub.herokuapp.com "
      }
    , { name = "Adaptive ‘Smart’ Stroller"
      , role = "Lead Developer"
      , location = "New York, NY"
      , dates = "2014 - 2015"
      , details =
            [ "Built stroller-attachable baby monitor with 2-way SMS communication with parent"
            , "Arduino for sensors, Python/Raspberry-Pi for communication, Python for SMS and web server"
            , "Used serial port (Arduino-to-Pi), HTTP (Pi-to-server), and SMS (server-to-phones)"
            ]
      , more = Nothing
      , repo = Just "http://github.com/kdz/BME_monitor_kdz"
      , demo = Nothing
      }
    , { name = "PySTEMM: K-12 STEM Education Tool"
      , role = "Sole Developer"
      , location = "Austin, TX"
      , dates = "2012 - 2014"
      , details =
            [ "Created and developed Python-based concept modeling tool"
            , "Presented work at 6th Annual International SciPy Conference in Brussels, Belgium"
            ]
      , more = Nothing
      , repo = Just "http://github.com/kdz/pystemm"
      , demo = Nothing
      }
    , { name = "MIT/SeaGrant Ocean Engineering Experience"
      , role = "Project and CS Lead"
      , location = "Cambridge, MA"
      , dates = "Summer 2012"
      , details =
            [ "Led 4-student team, built submersible ROV to monitor power plant effluents in river"
            , "Designed, built and tested with minimal guidance, on time and within budget"
            ]
      , more = Nothing
      , repo = Nothing
      , demo = Nothing
      }
    ]


activities : List FlatItem
activities =
    [ FlatItem "Girls who Code: Teaching Assistant" "2015-present"
    , FlatItem "Society of Women Engineers: Family member and house member" "2014-present"
    , FlatItem "Women in Computer Science: Member" "2014-present"
    , FlatItem "Application Development Initiative (ADI): Member" "2014-present"
    , FlatItem "Engineers Without Borders, Uganda Chapter: Board Financial Chair, Engineering team" "2014-2015"
      -- , FlatItem "Varsity Tennis: Captain, player, assistant coach of middle school team" "2011-2014"
      -- , FlatItem "DECA Business Competition: Team Leader, International finalist" "May 2014"
    ]


traits : List String
traits =
    [ "Love Computing", "Critical Thinking", "Self-starter", "Teamwork", "Communication", "Hard Working" ]
