;; -*- lexical-binding: t; -*-

(require 'json)

(with-temp-buffer
  (insert
   (json-encode
    `((themes . ,(cons "default" (custom-available-themes)))
      (modes  . ,(seq-sort
                  #'string<
                  (seq-filter
                   (lambda (name)
                     (string-suffix-p "-mode" name))
                   (delete-dups
                    (mapcar #'symbol-name
                            (seq-filter #'symbolp
                                        (mapcar #'cdr auto-mode-alist))))))))))
  (json-pretty-print-buffer-ordered)
  (write-region nil nil "data.json"))
