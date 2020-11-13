require("dotenv").config();
const debug = require("debug")("highlight");
const { exec } = require("child_process");
const fs = require("fs");

const commandTemplate = process.env.COMMAND_TEMPLATE;
const data = JSON.parse(fs.readFileSync("public/data.json"));

async function highlight(mode, code, theme, backgroundMode) {
  return new Promise((resolve, reject) => {
    if (!(mode && code)) {
      reject(new Error("highlight: Missing mode and/or code"));
      return;
    }
    if (!data.modes.includes(mode)) {
      reject(new Error("highlight: No such mode"));
      return;
    }
    if (theme && !data.themes.includes(theme)) {
      reject(new Error("highlight: No such theme"));
      return;
    }
    if (backgroundMode && backgroundMode !== "dark") {
      reject(new Error("highlight: No such backgroundMode"));
      return;
    }
    let args = ` --mode ${mode} `;
    if (theme && theme !== "default") args += ` --theme ${theme} `;
    if (backgroundMode) args += ` --background-mode ${backgroundMode} `;
    const command = commandTemplate.replace("%s", args);
    debug("COMMAND: %s", command);
    // XXX Avoid the shell
    const proc = exec(command, (error, stdout, stderr) => {
      debug("RESULT: %O", { error, stdout, stderr });
      resolve({ error, stdout, stderr });
    });
    proc.stdin.end(code);
  });
}

module.exports = highlight;
