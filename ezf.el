;;; ezf.el --- emacs fuzzy finder                    -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Mickey Petersen

;; Author: Mickey Petersen <mickey at masteringemacs.org>
;; Keywords: tools, tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Filter and select matches on the command line using your favourite
;; completion framework in Emacs.  It's an Emacs version of `fzf', a
;; command line tool that does basic fuzzy finding and selection using
;; a curses-like program.
;;
;; Unlike `fzf' this package + a shell script uses your Emacs instead!
;; That means it works well in `shell-mode' -- or equally well in
;; internal or external terminals -- and with the benefit of calling
;; out to your existing Emacs instance using `emacsclient'.
;;
;; Pipe data into `ezf' and you'll be prompted to filter and select
;; from the candidates in Emacs.
;;

;;; Examples:

;;
;;    # Search for debian packages and pass the matches to `ezf'
;;    $ apt-cache search emacs | ezf -f 1
;;
;;    # Filter matches from `find' and pass them to `wc'
;;    $ wc -l $(find . -name '*.txt' | ezf)
;;

;;; Code:

(defun ezf-default (filename)
  "Complete candidates in FILENAME with `completing-read'."
  (completing-read-multiple
   "Pick a Candidate: "
   (with-temp-buffer
     (insert-file-contents-literally filename nil)
     (string-lines (buffer-string) t))))


(defun ezf-helm (filename)
  "Complete candidates in FILENAME with `helm'."
  ;; Uncomment if you want Helm to full screen.
  (helm-set-local-variable 'helm-full-frame t)
  (helm :sources
        (helm-build-in-file-source "EZF Completion" filename
          :action (lambda (_) (helm-marked-candidates)))))

(defvar ezf-separators " "
  "Regexp of separators `ezf' should use to split a line.")

(defun ezf (filename &optional field completing-fn)
  "Wrapper that invokes COMPLETION-FN with FILENAME.

Optionally split each line of string by `ezf-separators' if FIELD
is non-nil and return FIELD.

If COMPLETING-FN is nil default to `ezf-default'."
  (when-let (candidates (funcall (or completing-fn 'ezf-helm) filename))
    (mapconcat (lambda (candidate)
                 (shell-quote-argument
                  (if field
                      (nth (1- field) (split-string candidate ezf-separators t " "))
                    candidate)))
               candidates
               " ")))


(provide 'ezf)
;;; ezf.el ends here
