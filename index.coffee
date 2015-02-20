express = require "express"
session = require "express-session"
http = require "http"
path = require "path"
compression = require "compression"
#routes = require "./private/routes"
db = require "./private/db/connect"
passport = require "passport"
TwitterStrategy = require("passport-twitter").Strategy
Constants = require "./private/constants"
hbs = require "hbs"

User = require "./private/models/user"

app = express()
app.use compression()
app.set "port", process.env.PORT || 3000
app.set "views", path.join(__dirname, "/private/views")
app.set "view engine", "hbs"
app.engine "html", hbs.__express
app.use express.static(path.join(__dirname, "/build"))
app.use session
  secret: "keyboard"
  saveUninitialized: true
  resave: true

passport.use new TwitterStrategy
  consumerKey: Constants.TWITTER_CONSUMER_KEY
  consumerSecret: Constants.TWITTER_CONSUMER_SECRET
  callbackURL: "http://localhost:3000/auth/twitter/callback"
, (token, tokenSecret, profile, done) ->
  user = new User
    username: profile.username
    displayName: profile.displayName
    profile: profile._json.profile_image_url
  user.save (err, user) ->
    if err
      return done(err)
    done null, user

app.get "/", (req, res) ->
  User.find (err, users) ->
    if err
      res.render "index"
    else
      res.render "index",
        title: "Express Todo Example"
        users: users

app.get "/auth/twitter", passport.authenticate("twitter")

app.get "/auth/twitter/callback", passport.authenticate("twitter", successRedirect: "/", failureRedirect: "/error")

app.get "/error", (req, res) ->
  console.log req, res

app.listen app.get("port")
