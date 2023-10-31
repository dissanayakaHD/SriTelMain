const express = require("express");
require("./db");
const Bill = require("./bill");
const PORT = process.env.PORT || 8083;

const app = express();
app.use(express.json());

app.get("/create/:userId", (req, res) => {
  const minValue = 1000;
  const maxValue = 5000;

  const amount =
    Math.floor(Math.random() * (maxValue - minValue + 1)) + minValue;
  const dueAmount =
    Math.floor(Math.random() * (maxValue - minValue + 1)) + minValue;
  const paybleAmount = amount + dueAmount;
  const bill = new Bill({
    userId: req.params.userId,
    amount: amount,
    dueAmount: dueAmount,
    paybleAmount: paybleAmount,
  });
  bill.save((err, bill) => {
    if (err) {
      res.status(500).json(err);
    } else {
      res.json(bill);
    }
  });
});

app.get("/get/:userId", (req, res) => {
  Bill.findOne({ userId: req.params.userId })
    .then((bill) => {
      res.json(bill);
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

app.get("/ping", (req, res) => {
  console.log("PING");
  res.json({
    message: "pong",
  });
});

app.listen(PORT, () => {
  console.log("Server running on PORT : " + PORT);
});
