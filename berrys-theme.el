;;; berrys-themes.el --- A mostly monochrome dark/light theme -*- lexical-binding: t; -*-

;; Copyright © 2019-present Slava Buzin

;; Title: Berrys Theme
;; Project: berrys-theme
;; Version: 0.2.0
;; URL: https://github.com/vbuzin/berrys-theme
;; Author: Slava Buzin <v8v.buzin@gmail.com>
;; Package-Requires: ((emacs "24.1"))
;; License: MIT

;;; Commentary:

;; Berrys is built to run in GUI mode with support for some
;; third-party syntax- and UI packages.

;;; Code:

(defun berrys-create (variant theme-name)
  "Define colors with VARIANT and NAME"

  (let ((colors '(
                  (berrys-bg      "#282A34" "#FAFAFA" "black")
                  (berrys-red     "#e36a5b" "#B80C09" "red")
                  (berrys-green   "#00AC00" "#00AC00" "green")
                  (berrys-yellow  "#D89800" "#D89800" "yellow")
                  (berrys-blue    "#40ADF9" "#1098F7" "blue")
                  (berrys-purple  "#C678DD" "#C678DD" "magenta")
                  (berrys-fg      "#E1E1E1" "#282A34" "white")
                  (berrys-cyan    "#07BEB8" "#07BEB8" "brightcyan")

                  (berrys-comment "#A2A4B3" "#646881" "gray")        ; comment
                  (berrys-current "#C1C3CD" "#C1C3CD" "brightblack") ; current-line/selection

                  ;; shades
                  (berrys-fg1     "#FAFAFA" "#282A34" "unspecified")
                  (berrys-fg2     "#C1C3CD" "#505367" "unspecified")


                  ))



        (faces  '(
                  (default :background ,berrys-bg :foreground ,berrys-fg)
                  (error :foreground ,berrys-red :weight bold)
                  (fixed-pitch-serif :family unspecified)
                  (font-lock-builtin-face :foreground ,berrys-fg2 :weight semi-bold)
                  (font-lock-comment-face :foreground ,berrys-comment :slant italic)
                  (font-lock-comment-delimiter-face :foreground ,berrys-comment :slant italic)
                  (font-lock-constant-face :foreground ,berrys-fg :weight bold)
                  (font-lock-doc-face :inherit font-lock-comment-face)
                  (font-lock-function-name-face :foreground ,berrys-blue :weight bold)
                  (font-lock-keyword-face :foreground ,berrys-fg1 :weight extra-bold)
                  (font-lock-string-face :foreground ,berrys-comment)
                  (font-lock-type-face :foreground ,berrys-fg1 :slant italic)
                  (font-lock-variable-name-face :foreground ,berrys-cyan)
                  (shadow :foreground ,berrys-comment)
                  (warning :foreground ,berrys-yellow :weight bold)


                 )))

    (apply #'custom-theme-set-faces
           theme-name
           (let ((expand-with-func
                  (lambda (func spec)
                    (let (reduced-color-list)
                      (dolist (col colors reduced-color-list)
                        (push (list (car col) (funcall func col))
                              reduced-color-list))
                      (eval `(let ,reduced-color-list
                               (backquote ,spec))))))
                 berrys-theme)

             (pcase-dolist (`(,face . ,spec) faces)
               (push `(,face
                       ((((min-colors 16777216))
                         ,(if (eq variant 'dark)
                              (funcall expand-with-func 'cadr spec)  ; dark
                            (funcall expand-with-func 'caddr spec))) ; light
                        (t
                         ,(funcall expand-with-func 'cadddr spec)))) ; tty
                     berrys-theme))
             berrys-theme))
    ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide 'berrys-theme)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:

;; LocalWords:  berrys

;;; berrys-theme.el ends here
