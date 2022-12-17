;;; day7.el --- Advent of Code 2022 Day 7                 -*- lexical-binding: t; -*-

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

(defun day7 ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "input")
    (let ((p1 0) (p2 70000000) (fs (make-hash-table :test 'equal)))

      (let (subdirs files path begls endls)
        (while (not (eobp))
          (cond         
           ((looking-at "$ cd \\(/\\|[a-z]+\\)")
            (when begls
              (puthash (apply #'concat path) (list files subdirs) fs)
              (setq endls t))
            (push (match-string 1) path))
           ((looking-at "$ ls")
            (setq begls t))
           ((looking-at "[0-9]+ ")
            (push (read (current-buffer)) files))         
           ((looking-at "dir \\([a-z]+\\)")
            (push (apply #'concat (match-string 1) path) subdirs))
           ((looking-at-p "$ cd \\.\\.")
            (when begls
              (puthash (apply #'concat path) (list files subdirs) fs)
              (setq endls t))
            (pop path)))
          (and begls endls (setq subdirs nil files nil begls nil endls nil))
          (forward-line))
        (puthash (apply #'concat path) (list files subdirs) fs))
      
      (cl-labels
          ((dir-size (v)
             (let ((size 0))
               (if (car v)
                   (cl-incf size (apply #'+ (car v))))
               (if (cdr v)
                   (dolist (p (cadr v))
                     (cl-incf size (dir-size (gethash p fs)))))
               size)))
        
        (let ((left (- 70000000 (dir-size (gethash "/" fs)))))
          (maphash
           (lambda (k v)
             (let ((size (dir-size v)))
               (if (<= size 100000) (cl-incf p1 size))
               (and (>= (+ size left) 30000000) (< size p2)
                    (setq p2 size)))) fs)
          (message "Part I:  %s\nPart II: %s" p1 p2))))))

(provide 'day7))
;;; day7.el ends here
