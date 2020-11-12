const highlight = require("./highlight.js");

test("highlight a line of js", async () => {
  const { error, stdout, stderr } = await highlight("js-mode", "const x = 42");
  expect(error).toBeNull();
  expect(stdout).not.toEqual("");
  expect(stderr).toEqual("");
});

test("ignore unknown mode", async () => {
  const { error, stdout, stderr } = await highlight(
    "unknown-mode",
    "const x = 42"
  );
  expect(error).toBeNull();
  expect(stdout).not.toEqual("");
  expect(stderr).toEqual("");
});

test("reject missing argument", async () => {
  await expect(highlight()).rejects.toThrow(Error);
});
