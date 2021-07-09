;;; nv-delete-forward.el --- Forward delete like modern text editors -*- lexical-binding: t -*-

;; Copyright (C) 2019 Nicolas Vaughan

;; Author: Nicolas Vaughan <n.vaughan [at] oxon.org>
;; Keywords: lisp
;; Package-Version: 20191113.1342
;; Version: 20191113.1342
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.1"))
;; Homepage: https://gitlab.com/nivaca/nv-delete-forward

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package replicates the forward delete behavior of modern text editors like oXygen XML or Sublime Text.

;;; Code:

;;;###autoload
(defun nv-delete-forward-all ()
  "Forward deletes either (i) all empty lines, or (ii) one whole word, or (iii) a single non-word character."
  (interactive)
  ;; If region is selected, delete it:
  (if (region-active-p)
      ;; then:
      (delete-region (region-beginning) (region-end))
    ;; else continue:
    (let ((nl-p nil))
      ;; First part:
      ;; Look forward and find if we have to do a full forward-delete
      (save-excursion
        (while (looking-at "[\n\s-]")
          (progn
            (if (looking-at "[\s-]")
                (while (looking-at "[\s-]")
                  (right-char 1)))
            (if (looking-at "[\n]")
                (progn
                  (while (looking-at "[\n]")
                    (right-char 1))
                  (setq nl-p t))))))
      ;; Second part:
      ;; Do we have to do a full forward-delete?
      (if nl-p
          (if (looking-at "[\n\s-]")
              ;; delete all spaces and newline chars behind the point
              (while (looking-at "[\n\s-]")
                (delete-char 1)))
        ;; else, delete one word
        (progn
          ;; delete all trailing spaces
          (if (looking-at "[\s-]")
              (while (looking-at "[\s-]")
                (delete-char 1)))
          ;; delete one word
          (nv-delete-forward-word 1))))))


;;;###autoload
(defun nv-delete-forward ()
  "Forward-deletes either (i) all spaces, (ii) one whole word, or (iii) a single non-word/non-space character."
  (interactive)
  ;; If region is selected, delete it:
  (if (region-active-p)
      ;; then:
      (delete-region (region-beginning) (region-end))
    ;; else continue:
    ;; Do we have a newline char behind the point?
    (if (looking-at "[\n]")
        ;; then, delete the newline char
        (delete-char 1)
      ;; else
      (progn
        ;; delete all spaces behind the point
        (while (looking-at "[[:space:]]")
          (delete-char 1))
        ;; and finally delete one word
        (nv-delete-forward-word)))))



;;;###autoload
(defun nv-delete-forward-word (&optional amount)
  "Forward-deletes either (i) one whole word, or (ii) a single non-word character.  If AMOUNT is supplied, the function will delete AMOUNT times of words or non-word characters.  The function can also be called with a prefix."
  (interactive "p")
  ;; set default of 1 for optional argument 'amount'
  (let ((amount (or amount 1)))
    ;; begin our decreasing while loop
    (while (>= amount 1)
      ;; first check if text is selected
      (if (region-active-p)
          ;; then:
          (delete-region (region-beginning) (region-end))
        ;; else continue:
        (progn
          ;; now, first check if there are any spaces
          (if (looking-at "[[:space:]]")
              ;; then, delete all spaces
              (while (looking-at "[[:space:]]")
                (delete-char 1)))
          ;; second, proceed to check if there is a word
          (if (looking-at "[[:alnum:]]")
              ;; then proceed to forward-delete it
              (while (looking-at "[[:alnum:]]")
                (delete-char 1))
            ;; else: check whether there is a non-word-non-space char
            (if (looking-at "[^[:alnum:][:space:]\n]")
                (delete-char 1)))))
      (setq amount (1- amount)))))

(provide 'nv-delete-forward)
;;; nv-delete-forward.el ends here
