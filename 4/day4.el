;;; day4.el --- Advent of Code 2022 Day 4            -*- lexical-binding: t; -*-

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

;; 958 957

;;; Code:

(defun day4-solve ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "input")
    (let ((p1 0) (p2 0))
      (while (re-search-forward
              "\\([0-9]+\\)-\\([0-9]+\\),\\([0-9]+\\)-\\([0-9]+\\)" nil t)
        (let ((l1 (string-to-number (match-string 1)))
              (u1 (string-to-number (match-string 2)))
              (l2 (string-to-number (match-string 3)))
              (u2 (string-to-number (match-string 4))))
          (if (or (and (<= l1 l2) (>= u1 u2)) (and (<= l2 l1) (>= u2 u1)))
              (incf p1))
          (if (or (and (<= l1 l2) (>= u1 l2)) (and (<= l2 l1) (>= u2 l1)))
              (incf p2))))
      (message "Part I:  %s\nPart II: %s" p1 p2))))

(provide 'day4)
;;; day4.el ends here
