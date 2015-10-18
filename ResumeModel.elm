module ResumeModel where

header = {
    name = "Kelsey D'Souza",
    affils = ["Computer Science, Columbia University"],
    photo = "images/kelsey_resume.png",
    address = "1954 Lerner Hall, 2920 Broadway, New York NY 10027 (Columbia University)",
    home = "9901 Spicewood Mesa, Austin, TX 78759",
    email = "kad2185@columbia.edu",
    phone = "512-363-9556",
    linkedin = "https://goo.gl/xcSDtb", -- "https://www.linkedin.com/in/kelseydsouza",
    github = "https://github.com/kdz",
    homepage = "https://kdz.github.io"
  }

education = [ { 
    name = "Columbia University, School of Engineering and Applied Science",
    location = "New York, NY",
    dates = "Fall 2014 - present",
    role = "Full-time student",
    details = [ "BS in Computer Science, Minor in Applied Math: Expected May 2018" ]
  }
 ]

type alias Item = {
    role : String,
    name : String,
    location : String,
    dates : String,
    details : List String
  }

work : List Item
work = [
    { role = "Teaching Assistant",  -- "Course Assistant" is Columbia title for pay
      name = "Columbia University",
      location = "New York, NY",
      dates = "Fall 2015",
      details = [
        "Teaching Assistant for Computer Science course E1006, \"Computation in Python\"",
        "Hold office-hours to assist students one-on-one, work with Dr. Adam Cannon"
      ]
    },

    { role = "Summer intern",
      name = "Enthought Scientific Computing",
      location = "Austin, TX",
      dates = "Summer 2015",
      details = [
        "Built interactive data visualizer feature in Python for Enthought Canopy data platform",
        "Worked in large live GitHub repository on individual feature branch and bug fix branches",
        "Used Python libraries Matplotlib, Pandas, Seaborn, and some Qt for front end tweaks"
      ]
    },

    { role = "Research Intern",
      name = "UT Austin Iyer Lab, Functional Genomics",
      location = "Austin, TX",
      dates = "Summer 2014",
      details = [
        "Assisted Dr. Gregory Hatlestad’s in researching coloration enzymes in plant DNA",
        "Performed PCR, gel electrophoresis, bacterial transformations and DNA analysis"
      ]
    }
  ]

projects : List Item
projects = [
  { role = "Sole Developer",
    name = "Assembly Language Simulator in Elm",
    location = "New York, NY",
    dates = "Fall 2015",
    details = [
      "A single-page application for an interactive Assembly Language Simulator",
      "Project implemented in Elm, a pure functional programming language"
    ]
  },

  { role = "Sole Modeler",
    name = "Executable domain models",
    location = "New York, NY",
    dates = "Fall 2015",
    details = [
      "Models of concepts in different domains to improve my own understanding",
      "Models implemented using Elm, a pure functional programming language"
    ]
  },

  { role = "Lead Developer",
    name = "EboHub: Ebola/Infectious Disease Surveillance System",
    location = "New York, NY",
    dates = "2014 - 2015",
    details = [
      "Led team of 5, built system for mobile healthcare workers doing disease surveillance",
      "Python/Postgresql web service with 2-way SMS-based mobile and web interfaces",
      "Columbia Ebola Design Challenge finalist, worked with Guinea-based NGO"
    ]
  },

  { role = "Lead Developer",
    name = "Adaptive ‘Smart’ Stroller",
    location = "New York, NY",
    dates =  "2014 - 2015",
    details = [
      "Built stroller-attachable baby monitor with 2-way SMS communication with parent",
      "Arduino - sensors, Python/Raspberry-Pi - communication, Python - SMS and web server",
      "Serial port (Arduino-to-Pi), HTTP (Pi-to-server), and SMS (server-to-phones)"
    ]
  },

  { role = "Personal Project",
    name = "PySTEMM: K-12 STEM Education Tool",
    location = "Austin, TX",
    dates = "2012 - 2014",
    details = [
      "Created and developed Python-based concept modeling tool",
      "Presented work at 6th Annual International SciPy Conference in Brussels, Belgium"
    ]
  },

  { role = "Project and CS Lead",
    name = "MIT/SeaGrant Ocean Engineering Experience",
    location = "Cambridge, MA",
    dates = "Summer 2012",
    details = [
      "Led 4-student team, built submersible ROV to monitor power plant effluents in river",
      "Designed, built and tested with minimal guidance, on time and within budget"
    ]
  }
 ]

publications = [
  { name = "PySTEMM: Executable Concept Modeling for K-12 Learning",
    role = "Sole author",
    location = "Brussels, Belgium",
    dates = "August 2013",
    details = [
      "Proceedings of the 6th European Conference on Python in Science (EuroSciPy 2013)",
      "Independently developed Python-based concept modeling tool to assist STEM learning"
    ]
  }
  ]

activities = [
  ("Society of Women Engineers", "Family member and house member", "2014-present"),
  ("Women in Computer Science", "Member", "2014-present"),
  ("Girls who Code", "Teaching Assistant", "Fall 2015-present"),
  ("Application Development Initiative (ADI)", "Member", "2014-present"),
  ("Engineers Without Borders: Uganda Chapter", "Board Financial Chair, Engineering team", "2014-2015"),
  ("Varsity Tennis", "Captain, player, assistant coach of middle school team", "2011-2014"),
  ("DECA Business Competition", "Team Leader, International finalist", "May 2014")
  ]

skills = [
  ("Python", "highly proficient"),
  ("Elm", "proficient"),
  ("C, C++, Java, SQL, Matlab, HTML, CSS, Javascript", "basic usage")
  ]

traits = [ "Love Computing", "Critical Thinking", "Self-starter", "Teamwork", "Communication", "Hard Working" ]
