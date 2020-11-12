require("dotenv").config();
const debug = require("debug")("highlight");
const { exec } = require("child_process");

const commandTemplate = process.env.COMMAND_TEMPLATE;

async function highlight(mode, code, theme, backgroundMode) {
  return new Promise((resolve, reject) => {
    if (!(mode && code)) {
      reject(new Error("highlight: Missing mode and/or code"));
    }
    let args = ` --mode ${mode} `;
    if (theme && theme !== "default") args += ` --theme ${theme} `;
    if (backgroundMode) args += ` --background-mode ${backgroundMode} `;
    const command = commandTemplate.replace("%s", args);
    debug("COMMAND: %s", command);
    const proc = exec(command, (error, stdout, stderr) => {
      debug("RESULT: %O", { error, stdout, stderr });
      resolve({ error, stdout, stderr });
    });
    proc.stdin.end(code);
  });
}

module.exports = highlight;
