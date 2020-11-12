const debug = require("debug")("highlight");
const { exec } = require("child_process");

const commandTemplate =
  "/Users/xcy/src/emacs-mac/src/emacs -Q --batch -l /Users/xcy/.emacs.d/elpa-27.1/face-explorer-20190517.1857/face-explorer.el -l /Users/xcy/.emacs.d/elpa-27.1/e2ansi-20190517.1902/e2ansi.el -l /Users/xcy/.emacs.d/elpa-27.1/e2ansi-20190517.1902/bin/e2ansi-cat --mode %s - | ansi-to-html";

async function highlight(mode, code) {
  return new Promise((resolve, reject) => {
    if (!(mode && code)) {
      reject(new Error("highlight: Missing mode and/or code"));
    }
    const command = commandTemplate.replace("%s", mode);
    debug("COMMAND: %s", command);
    const proc = exec(command, (error, stdout, stderr) => {
      debug("RESULT: %O", { error, stdout, stderr });
      resolve({ error, stdout, stderr });
    });
    proc.stdin.end(code);
  });
}

module.exports = highlight;
