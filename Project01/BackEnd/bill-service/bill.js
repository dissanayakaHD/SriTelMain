const { Schema, model } = require("mongoose");

const BillSchema = new Schema({
  userId: {
    type: String,
    required: true,
  },
  amount: {
    type: Number,
    required: true,
  },
  dueAmount: {
    type: Number,
    required: true,
  },
  paybleAmount: {
    type: Number,
    required: true,
  },
});

module.exports = model("Bill", BillSchema);
