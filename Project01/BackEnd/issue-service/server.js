const express = require("express");
require("./db");
const Issue = require("./issue");
const PORT = process.env.PORT || 8084;

const app = express();
app.use(express.json());

app.post("/create", async (req, res) => {
  await Issue.create(req.body)
    .then((issue) => {
      res.json(issue);
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

// get the issues based on the userId
app.get("/list/:userId", async (req, res) => {
  await Issue.find({ userId: req.params.userId })
    .then((issues) => {
      res.json(issues);
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
