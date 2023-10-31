const express = require("express");
require("./db");
const Chat = require("./chat");
const PORT = process.env.PORT || 8085;

const app = express();
app.use(express.json());

app.post("/create", (req, res) => {
  Chat.create(req.body)
    .then((chat) => {
      res.json(chat);
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

app.get("/user/:userId", (req, res) => {
  Chat.find({ userId: req.params.userId })
    .then((chat) => {
      res.json(chat);
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
