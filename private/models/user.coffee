mongoose = require "mongoose"
Schema = mongoose.Schema

userSchema = new Schema
  created:
    type: Date
    default: Date.now
  username:
    type: String
    unique: true
  displayName: String
  profile: String

module.exports = mongoose.model("User", userSchema)
