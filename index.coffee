express = require "express"
session = require "express-session"
http = require "http"
path = require "path"
compression = require "compression"
db = require "./private/db/connect"
passport = require "passport"
TwitterStrategy = require("passport-twitter").Strategy
Constants = require "./private/constants"
hbs = require "hbs"
User = require "./private/models/user"
# todo use routes..

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
  callbackURL: "http://growthglasgow.com/auth/twitter/callback"
, (token, tokenSecret, profile, done) ->
  user = new User
    username: profile.username
    displayName: profile.displayName
    profile: profile._json.profile_image_url
  user.save (err, user) ->
    if err
      return done(err)
    done null, user

app.get "/auth/twitter", passport.authenticate("twitter")
app.get "/auth/twitter/callback", passport.authenticate("twitter", successRedirect: "/", failureRedirect: "/")

app.get "/users", (req, res) ->
  User.find().lean().exec (err, users) ->
    res.end(JSON.stringify(users))

app.listen app.get("port")
