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

passport.serializeUser (user, done) ->
  done(null, user)

passport.deserializeUser (obj, done) ->
  done(null, obj)

passport.use new TwitterStrategy
  consumerKey: Constants.TWITTER_CONSUMER_KEY
  consumerSecret: Constants.TWITTER_CONSUMER_SECRET
  callbackURL: "/auth/twitter/callback"
, (token, tokenSecret, profile, done) ->
  user = new User
    username: profile.username
    displayName: profile.displayName
    profile: profile._json.profile_image_url
  user.save (err, user) ->
    done null, user

app = express()
app.use compression()
app.set "port", process.env.PORT || 3000
app.set "views", path.join(__dirname, "/private/views")
app.set "view engine", "hbs"
app.engine "html", hbs.__express
app.use express.static(path.join(__dirname, "/build"))
app.use(passport.initialize())
app.use(passport.session())
app.use session
  secret: "keyboard"
  saveUninitialized: true
  resave: true

app.get "/auth/twitter", passport.authenticate("twitter")

app.get "/auth/twitter/callback",
  passport.authenticate("twitter", failureRedirect: "/"),
  (req, res) ->
    res.redirect("/")

app.get "/users", (req, res) ->
  User.find().lean().exec (err, users) ->
    res.end(JSON.stringify(users))

app.listen app.get("port")
