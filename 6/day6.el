;;; day6.el --- Advent of Code 2022 Day 6            -*- lexical-binding: t; -*-

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

(defun day6-solve ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "input")
    (cl-labels
        ((find-it (&optional L)
           (let (chars c)
             (catch 'done
               (while (char-after)
                 (if (= (length chars) L) (throw 'done t))
                 (setq chars (nreverse chars))
                 (while (member (char-after) chars) (pop chars))
                 (setq chars (nreverse chars))
                 (push (char-after) chars)
                 (forward-char)))
             (1- (point)))))
      (let ((p1 (find-it 4)) p2)
        (goto-char 1)
        (setq p2 (find-it 14))
        (message "Part I:  %s\nPart II: %s" p1 p2)))))

(provide 'day6)
;;; day6.el ends here
