;;; day10.el --- Advent oc Code Day 10               -*- lexical-binding: t; -*-

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
(require 'svg)

(defun day10 ()
  (interactive)

  (let ((img (svg-create 800 119))
        (p1 0)
        (cycle 1) (x 1) (checkpoint 20) (op t) (w 0)
        (green "#00873E")
        (pinky "#D41596")
        (W 20) (H 20) (X 0) (Y 0) pixel-pos)
    
    (with-temp-buffer
      (insert-file-contents "input")
      
      (ignore-errors
        (while op
          (setq pixel-pos (% cycle 40))
          
          (svg-rectangle
           img X Y W H :fill-color
           (if (<= x pixel-pos (+ x 2)) green pinky))

          (setq op (read (current-buffer)))
          (setq w (if (numberp op) op 0))
          
          (when (= cycle checkpoint)
            (cl-incf p1 (* checkpoint x))
            (cl-incf checkpoint 40))

          (cl-incf x w)
          
          (cond  ((= pixel-pos 0)
                  (setq X 0))
                 ((= (% (1+ cycle) 40) 0)
                  (cl-incf Y H))
                 (t (cl-incf X W)))

          (cl-incf cycle))))
    
    (message "Part  I: %s" p1)
    (goto-char (point-max))
    (svg-insert-image img))) ;; part II

(provide 'day10)
;;; day10.el ends here
 
