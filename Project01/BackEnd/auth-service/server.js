const express = require("express");
const cors = require("cors");
require("./db");
const User = require("./user");
const PORT = process.env.PORT || 8081;
const axios = require("axios");

const app = express();
app.use(express.json());

app.post("/signup", async (req, res) => {
  await User.findOne({
    email: req.body.email,
  })
    .then(async (user) => {
      if (user) {
        res.status(400).json({
          message: "User already exists",
        });
      } else {
        await User.create(req.body)
          .then(async (user) => {
            //send the userid to the VAS service to create a new list
            await axios.post("http://localhost:8082/create", {
              userId: user.id,
            });
            // send the userid to the bill service to create a bill
            await axios.get("http://localhost:8083/create/" + user.id, {
              userId: user.id,
            });

            res.json(user);
          })
          .catch((err) => {
            res.status(500).json(err);
          });
      }
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

app.post("/login", async (req, res) => {
  await User.findOne({
    email: req.body.email,
  })
    .then((user) => {
      if (user) {
        if (user.password === req.body.password) {
          res.status(200).json(user);
        } else {
          res.status(400).json({
            message: "Invalid password",
          });
        }
      } else {
        res.status(400).json({
          message: "Invalid email",
        });
      }
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

// password reset request
app.post("/password-reset", async (req, res) => {
  await User.findOne({
    email: req.body.email,
  })
    .then((user) => {
      if (user) {
        // user.password = req.body.password;
        // user.save();
        res.json(user);
      } else {
        res.status(400).json({
          message: "Invalid email",
        });
      }
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

// PING
app.get("/ping", (req, res) => {
  console.log("PING");
  res.json({
    message: "pong",
  });
});

app.listen(PORT, () => {
  console.log("Server running on PORT : " + PORT);
});
