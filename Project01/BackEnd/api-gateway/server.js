const express = require("express");
const cors = require("cors");
const { createProxyMiddleware } = require("http-proxy-middleware");

const app = express();
app.use(cors());
const port = 8080;

// Define routes to proxy requests to specific backends
app.use(
  "/auth",
  createProxyMiddleware({
    target: "http://localhost:8081",
    pathRewrite: { "^/auth": "" },
  })
);

app.use(
  "/vas",
  createProxyMiddleware({
    target: "http://localhost:8082",
    pathRewrite: { "^/vas": "" },
  })
);

app.use(
  "/bill",
  createProxyMiddleware({
    target: "http://localhost:8083",
    pathRewrite: { "^/bill": "" },
  })
);

app.use(
  "/issue",
  createProxyMiddleware({
    target: "http://localhost:8084",
    pathRewrite: { "^/issue": "" },
  })
);

app.use(
  "/chat",
  createProxyMiddleware({
    target: "http://localhost:8085",
    pathRewrite: { "^/chat": "" },
  })
);

// Start the API gateway server
app.listen(port, () => {
  console.log(`API Gateway is running on port ${port}`);
});
