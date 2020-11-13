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

(setq package-check-signature nil)

(package-initialize)

(let ((packages '(e2ansi
                  ;; Themes
                  color-theme-sanityinc-tomorrow
                  cyberpunk-theme
                  spacemacs-theme
                  ;; Major modes
                  csharp-mode
                  php-mode
                  go-mode
                  rust-mode
                  haskell-mode))
      (refreshed nil))
  (dolist (pkg packages)
    (unless (package-installed-p pkg)
      (unless refreshed
        (package-refresh-contents)
        (setq refreshed t))
      (package-install pkg))))

(setq custom-safe-themes t)

(require 'e2ansi)
