;; -*- lexical-binding: t; -*-

(require 'json)

(write-region
 (json-encode `((themes . ,(cons "default" (custom-available-themes)))))
 nil
 "data.json")
