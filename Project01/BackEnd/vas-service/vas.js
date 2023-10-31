const { Schema, model } = require("mongoose");

const VasSchema = new Schema({
  userId: {
    type: String,
    required: true,
  },
  RingInTone: {
    type: Boolean,
    default: false,
  },
  Roaming: {
    type: Boolean,
    default: false,
  },
  NewsAlerts: {
    type: Boolean,
    default: false,
  },
  SportUpdates: {
    type: Boolean,
    default: false,
  },
  GPRSService: {
    type: Boolean,
    default: false,
  },
});

module.exports = model("Vas", VasSchema);
