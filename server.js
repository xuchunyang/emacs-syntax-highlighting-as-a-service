const debug = require("debug")("app");
const express = require("express");
const morgan = require("morgan");
const highlight = require("./highlight.js");

const app = express();

app.use(morgan("dev")); // logging

app.use(express.static("public"));

app.use(express.json()); // parse request's json body

app.post("/api/highlight", (req, res, next) => {
  debug("BODY: %O", req.body);
  const { mode, code } = req.body;
  highlight(mode, code)
    .then((data) => {
      if (data.error) {
        data.error = data.error.message;
      }
      res.json({ data });
    })
    .catch((error) => res.json({ error: error.message }));
});

const port = process.env.PORT || 3478;
app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}`);
});
