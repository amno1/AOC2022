;;; day1.el --- Advent of code 2022 - Day 1          -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Arthur Miller

;; Author: Arthur Miller <arthur.miller@live.com>
;; Keywords: 

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

;; 

;;; Code:

(defun day1-read-supply ()
  "Read supply from one raindeer."
  (let ((sum 0))
    (while (and (char-after) (/= ?\n (char-after)))
      (let ((input (read (current-buffer))))
        (setq sum (+ sum input)))
      (forward-line))
    sum))

(defun day1-read-supplies ()
  (with-temp-buffer
    (insert-file-contents-literally "./input")
    (switch-to-buffer (current-buffer))
    (let ((max 0) list)
      (while (not (eobp))
        (push (day1-read-supply) list)
        (forward-line))
      (cl-sort list '>))))

(defun day1-solve ()
  (interactive)
  (let* ((supplies (day1-read-supplies))
         (top (pop supplies))
         (top3 (+ top (pop supplies) (pop supplies))))
    (message "Part I: %s\nPart II: %s" top top3)))

(provide 'day1)
;;; day1.el ends here
