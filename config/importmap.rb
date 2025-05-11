pin "application"
pin "distribution_chart", to: "distribution_chart.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Recharts como módulo
pin "recharts", to: "https://esm.sh/recharts@2.8.0"
