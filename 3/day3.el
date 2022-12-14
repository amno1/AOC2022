;;; day3.el --- Advent of Code 2022 Day 3            -*- lexical-binding: t; -*-

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

(defun day3-solve ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "input")
    (let ((p1 0) (p2 0))
      (labels ((value (char) (if (> char ?Z) (- char 96) (- char 38))))
        (while (re-search-forward "\\(.+\\)\n\\(.+\\)\n\\(.+\\)\n" nil t)
          (let ((s1 (append (match-string 1) nil))
                (s2 (append (match-string 2) nil))
                (s3 (append (match-string 3) nil)))
            (incf p2 (value (car (intersection (intersection s1 s2) s3))))
            (dolist (s (list s1 s2 s3))
              (let* ((m (/ (length s) 2))
                     (ch (car (intersection (butlast s m) (last s m)))))
                (incf p1 (value ch)))))))
      (message "Part I:  %s\nPart II: %s" p1 p2))))

(provide 'day3)
;;; day3.el ends here
