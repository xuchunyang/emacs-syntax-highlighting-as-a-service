// Input:  index.handlebars
// Output: index.html

const fs = require("fs");
const Handlebars = require("handlebars");

const contents = fs.readFileSync("index.handlebars", "utf-8");
const template = Handlebars.compile(contents);

const data = JSON.parse(fs.readFileSync("data.json", "utf-8"));
const html = template(data);

fs.writeFileSync("index.html", html);
