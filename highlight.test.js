const highlight = require("./highlight.js");

test("highlight a line of js", async () => {
  const { error, stdout, stderr } = await highlight(
    "javascript-mode",
    "const x = 42"
  );
  expect(error).toBeNull();
  expect(stdout).not.toEqual("");
  expect(stderr).toEqual("");
});

test("reject missing argument", async () => {
  await expect(highlight()).rejects.toThrow(Error);
});

test("reject invalid mode, theme and backgroundMode", async () => {
  await expect(highlight("non-exists-mode", "")).rejects.toThrow(Error);
  await expect(
    highlight("emacs-lisp-mode", "", "non-exists-theme")
  ).rejects.toThrow(Error);
  await expect(
    highlight("emacs-lisp-mode", "", "default", "non-exists-backgroundMode")
  ).rejects.toThrow(Error);
});
