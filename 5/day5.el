;;; day5.el --- Advent of Code 2022 Day 5            -*- lexical-binding: t; -*-

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

(defun read-stacks ()
  (while (search-forward "]" nil t)
    (forward-line))
  (let ((i 1)
        (table (make-hash-table))
        stack stacks bound)
    (while (re-search-forward "[0-9]+" (line-end-position) t)
      (puthash (string-to-number (match-string 0)) nil table))
    (setq bound (point))
    (goto-char 1)
    (while (< (point) bound)
      (while (re-search-forward
              "\\[\\([A-Z]\\)\\]\\|\\(   \\) " (line-end-position) t)
        (when (match-string 1)
          (setq stack (gethash i table))
          (push (match-string 1) stack)
          (puthash i stack table))
        (incf i))
      (forward-line)
      (setq i 1))
    table))

(defun solve (&optional newmodel)
  (let ((table (read-stacks))
        stack stacks bound steps from to s1 s2 msg tmp)
    (goto-char 1)
    (while (search-forward "move" nil t)
      (setq steps (read (current-buffer)))
      (forward-word)
      (setq from (read (current-buffer)))
      (forward-word)
      (setq to (read (current-buffer))
            sf (nreverse (gethash from table))
            st (nreverse (gethash to table)))
      (dotimes (n steps) (push (pop sf) (if newmodel tmp st)))
      (when newmodel (while tmp (push (pop tmp) st)))
      (puthash from (nreverse sf) table)
      (puthash to (nreverse st) table))
    (dotimes (n (hash-table-count table))
      (setq stack (nreverse (gethash (1+ n) table)))
      (push (pop stack) msg))
    (apply #'concat (nreverse msg))))

(defun day5-solve ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "input")
    (message "Part I:  %s\nPart II: %s" (solve) (solve t))))

(provide 'day5)
;;; day5.el ends here
