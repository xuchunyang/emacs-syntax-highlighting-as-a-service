;; -*- lexical-binding: t; -*-

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'e2ansi)
  (package-refresh-contents)
  (package-install 'e2ansi))

(require 'e2ansi)
(if (null command-line-args-left)
    (e2ansi-batch-usage)
  (e2ansi-batch-convert))
