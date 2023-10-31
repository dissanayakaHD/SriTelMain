const { Schema, model } = require("mongoose");

const IssueSchema = new Schema({
  userId: {
    type: String,
    required: true,
  },
  messageContent: {
    type: String,
    required: true,
  },
  state: {
    type: Boolean,
    default: false,
  },
});

module.exports = model("Issue", IssueSchema);
