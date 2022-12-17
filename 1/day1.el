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

(defun day1 ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "./input")
    (let (supplies)
      (while (not (eobp))
        (let ((sum 0))
          (while (and (char-after) (/= ?\n (char-after)))
            (cl-incf sum (read (current-buffer)))
            (forward-line))
          (push sum supplies))
        (forward-line))
      (setq supplies (cl-sort supplies #'>))
      (message "Part I: %s\nPart II: %s"
               (car supplies) (apply #'+ (last (nreverse supplies) 3))))))

(provide 'day1)
;;; day1.el ends here
