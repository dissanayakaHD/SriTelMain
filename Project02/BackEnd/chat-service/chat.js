const { Schema, model } = require("mongoose");

const ChatSchema = new Schema({
  userId: {
    type: String,
    required: true,
  },
  messageContent: {
    type: String,
    required: true,
  },
  isAgent: {
    type: Boolean,
    default: false,
  },
});

module.exports = model("Chat", ChatSchema);
