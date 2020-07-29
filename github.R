

library(httr)
config()

script <- GET(
    url = "https://api.github.com/repos/diazdc/shiny-apps-main/test/bob.R",
    authenticate("walktheline@gmail.com", "8869c261d36d57ea3c5d5bacef3c760dec9fa181"),     # Instead of PAT, could use password
    accept("application/vnd.github.v3.raw")
  )
content(script, as = "text")
eval(parse(text = script))

#install.packages("jsonlite")
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
#install.packages("httr")
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")
 
# Change based on what you 
myapp <- oauth_app(appname = "App",
                   key = "475c4cb59a386b79e1c3",
                   secret = "6c629a56a14cca00b188501d7603679972a0d3a7")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/diazdc/repos/", gtoken)
req
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]