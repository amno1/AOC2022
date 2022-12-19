;;; day11.el --- Advent of Code 2022 Day 11               -*- lexical-binding: t; -*-

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

(cl-defstruct monkey items op div m1 m2 inspected)

(defvar lcm 1)

(defun read-monkeys ()
  (let ((monkeys (make-hash-table)))
    (with-temp-buffer
      (insert-file-contents "input")
      (while (re-search-forward "[0-9]+" nil t)
        (let (id i o d m1 m2)
          (setq id (string-to-number (match-string 0)))
          (search-forward "items: ")
          (while (re-search-forward "[0-9]+" (line-end-position) t)
            (push (string-to-number (match-string 0)) i))
          (search-forward " old ")
          (setq o (cons (read (current-buffer)) (read (current-buffer))))
          (re-search-forward " [0-9]+")
          (setq d (string-to-number (match-string 0)) lcm (* lcm d))
          (re-search-forward " [0-9]+")
          (setq m1 (string-to-number (match-string 0)))
          (re-search-forward " [0-9]+")
          (setq m2 (string-to-number (match-string 0)))
          (puthash id (make-monkey :items (nreverse i)
                                   :inspected 0 :op o :div d :m1 m1 :m2 m2)
                   monkeys))))
    monkeys))

(defun calc-part (times reductor)
  (let ((monkeys (read-monkeys)) inspected)
    (dotimes (_ times)
      (maphash
       (lambda (_ monkey)
         (let ((worries (monkey-items monkey))
               (operator (car (monkey-op monkey)))
               (operand (cdr (monkey-op monkey)))
               (divisor (monkey-div monkey))
               (m1 (monkey-m1 monkey))
               (m2 (monkey-m2 monkey))
               m)
           (cl-incf (monkey-inspected monkey) (length (monkey-items monkey)))
           (while worries
             (let ((worry (pop worries)))
               (setq worry (funcall operator worry (if (numberp operand)
                                                       operand worry))
                     worry (funcall reductor worry)
                     m (if (= (% worry divisor) 0)
                           (gethash m1 monkeys)
                         (gethash m2 monkeys)))
               (setf (monkey-items m) (append (monkey-items m) `(,worry)))))
           (setf (monkey-items monkey) nil)
           )) monkeys))
    (maphash (lambda (_ m) (push (monkey-inspected m) inspected)) monkeys)
    (setq inspected (cl-sort inspected '>))
    (apply #'* (ntake 2 inspected))))

(defun day11 ()
  (interactive)
  (message "Part  I: %s\nPart II: %s"
           (calc-part 20 (lambda (worry) (floor worry 3)))
           (calc-part 10000 (lambda (worry) (mod worry lcm)))))

(provide 'day11)
;;; day11.el ends here
