;;; day9.el --- Advent of Code 2022 Day 9            -*- lexical-binding: t; -*-

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

(defun day9 ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents "input")
    (let ((snake '((1 . 1) (1 . 1) (1 . 1) (1 . 1) (1 . 1)
                   (1 . 1) (1 . 1) (1 . 1) (1 . 1) (1 . 1)))
          (p1 (make-hash-table :test 'equal))
          (p2 (make-hash-table :test 'equal))
          (moves 0) (head 0) direction)
      (puthash (cons 1 1) t p1)
      (puthash (cons 1 1) t p2)

      (cl-labels
          ((next-input ()
             (when (= moves 0)
               (setq direction (ignore-errors (read (current-buffer)))
                     moves (ignore-errors (read (current-buffer)))))
             (when direction (cl-decf moves))
             direction)
           
           (move (piece direction)
             (pcase direction
               ('L (cl-decf (car (nth piece snake))))
               ('R (cl-incf (car (nth piece snake))))
               ('U (cl-incf (cdr (nth piece snake))))
               ('D (cl-decf (cdr (nth piece snake)))))))
        
        (while (next-input)

          (move head direction)
          
          (dotimes (i 9)
            (let ((dx (- (car (nth i snake)) (car (nth (1+ i) snake))))
                  (dy (- (cdr (nth i snake)) (cdr (nth (1+ i) snake)))))
              (cond
               ((and (> dx  1) (= dy  0)) (move (1+ i) 'R))
               ((and (< dx -1) (= dy  0)) (move (1+ i) 'L))
               ((and (= dx  0) (> dy  1)) (move (1+ i) 'U))
               ((and (= dx  0) (< dy -1)) (move (1+ i) 'D))
               ((and (> dx  0) (> dy  1)) (move (1+ i) 'R) (move (1+ i) 'U))
               ((and (< dx  0) (> dy  1)) (move (1+ i) 'L) (move (1+ i) 'U))
               ((and (> dx  0) (< dy -1)) (move (1+ i) 'R) (move (1+ i) 'D))
               ((and (< dx  0) (< dy -1)) (move (1+ i) 'L) (move (1+ i) 'D))
               ((and (> dx  1) (> dy  0)) (move (1+ i) 'R) (move (1+ i) 'U))
               ((and (< dx -1) (> dy  0)) (move (1+ i) 'L) (move (1+ i) 'U))
               ((and (> dx  1) (< dy  0)) (move (1+ i) 'R) (move (1+ i) 'D))
               ((and (< dx -1) (< dy  0)) (move (1+ i) 'L) (move (1+ i) 'D)))))

          (puthash (cons (car (nth 1 snake)) (cdr (nth 1 snake))) t p1)
          (puthash (cons (car (nth 9 snake)) (cdr (nth 9 snake))) t p2))
        (message "Part  I: %s\nPart II: %s"
                 (hash-table-count p1) (hash-table-count p2))))))

(provide 'day9)
;;; day9.el ends here
