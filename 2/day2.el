;;; day2.el --- Advent of Code 2022 Day 2            -*- lexical-binding: t; -*-

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

(defun day2-solve ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "input")
    (let ((p1 0) (p2 0))
      (while (re-search-forward "\\(.+\\)\n" nil t)
        (pcase (match-string 1)
          ("B X" (setq p1 (+ 0 1 p1) p2 (+ 0 1 p2)))
          ("C Y" (setq p1 (+ 0 2 p1) p2 (+ 3 3 p2)))
          ("A Z" (setq p1 (+ 0 3 p1) p2 (+ 6 2 p2)))
          ("A X" (setq p1 (+ 3 1 p1) p2 (+ 0 3 p2)))
          ("B Y" (setq p1 (+ 3 2 p1) p2 (+ 3 2 p2)))
          ("C Z" (setq p1 (+ 3 3 p1) p2 (+ 6 1 p2)))
          ("C X" (setq p1 (+ 6 1 p1) p2 (+ 0 2 p2)))
          ("A Y" (setq p1 (+ 6 2 p1) p2 (+ 3 1 p2)))
          ("B Z" (setq p1 (+ 6 3 p1) p2 (+ 6 3 p2)))))
      (message "Part I:  %s\nPart II: %s" p1 p2))))

(provide 'day2)
;;; day2.el ends here
