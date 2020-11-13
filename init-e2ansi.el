(require 'e2ansi)

(if (null command-line-args-left)
    (e2ansi-batch-usage)
  (e2ansi-batch-convert))
