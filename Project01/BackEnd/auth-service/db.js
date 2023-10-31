const mongoose = require("mongoose");

mongoose.connect(
  "mongodb+srv://test-auth:K8om8RszEc5DJCUe@cluster0.mlgrx.mongodb.net/auth-db?retryWrites=true&w=majority",
  (error) => {
    if (error) throw error;
  }
);

mongoose.connection.on("connected", () =>
  console.log("Connected to Mongo database")
);

mongoose.connection.on("error", () =>
  console.log("MongoDB Connection Unsuccessfull")
);
