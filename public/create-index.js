// Input:  index.handlebars
// Output: index.html

const fs = require("fs");
const Handlebars = require("handlebars");

const contents = fs.readFileSync("index.handlebars", "utf-8");
const template = Handlebars.compile(contents);

const data = {
  themes: [
    "default",
    "adwaita",
    "deeper-blue",
    "dichromacy",
    "leuven",
    "light-blue",
    "manoj-dark",
    "misterioso",
    "tango-dark",
    "tango",
    "tsdh-dark",
    "tsdh-light",
    "wheatgrass",
    "whiteboard",
    "wombat",
  ],
};

const html = template(data);

fs.writeFileSync("index.html", html);
