Constants = require "../constants"
mongoose = require "mongoose"
dbURI = Constants.MONGO_URL

mongoose.connect(dbURI)

mongoose.connection.on "connected", ->
  console.log "Connected to db #{dbURI}"

mongoose.connection.on "error", (err) ->
  console.log "Connection error: #{err}"

mongoose.connection.on "disconnected", ->
  console.log "Disconnected from DB."

process.on "SIGINT", ->
  mongoose.connection.close ->
    console.log "Disconnected from DB by app."
    process.exit(0)

require "./../models/user"
