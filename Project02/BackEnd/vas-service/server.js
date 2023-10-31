const express = require("express");
require("./db");
const Vas = require("./vas");
const PORT = process.env.PORT || 8082;

const app = express();
app.use(express.json());

app.post("/create", (req, res) => {
  Vas.create(req.body)
    .then((vas) => {
      res.json(vas);
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

app.patch("/update", (req, res) => {
  Vas.findOneAndUpdate(
    { userId: req.body.userId },
    { $set: req.body },
    { new: true }
  )
    .then((vas) => {
      res.json(vas);
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

app.get("/get/:userId", (req, res) => {
  Vas.findOne({ userId: req.params.userId })
    .then((vas) => {
      res.json(vas);
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
