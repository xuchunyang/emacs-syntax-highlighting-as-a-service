;; -*- lexical-binding: t; -*-

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(when (equal (getenv "ELPA_MIRROR") "tuna")
  (message "Using TUNA mirror")
  (setq package-archives
        '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))

(package-initialize)

(unless (package-installed-p 'e2ansi)
  (package-refresh-contents)
  (package-install 'e2ansi))

(require 'e2ansi)
(if (null command-line-args-left)
    (e2ansi-batch-usage)
  (e2ansi-batch-convert))
