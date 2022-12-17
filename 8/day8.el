;;; day8.el --- Advent of Code 2022 Day 8            -*- lexical-binding: t; -*-

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

(defun day8 ()
  (interactive)
  (with-temp-buffer
    (let (p1 (p2 0))    
      (insert-file-contents-literally "input")
      (let ((times (- (line-end-position) 3))
            (L (line-end-position)) tops)
        (dotimes (x times)
          (let ((H 0))
            (goto-char (+ (* (1+ x) L) 2))
            (dotimes (_ times)
              (setq H (max H (char-before)))
              (when (> (char-after) H)
                (add-to-list 'p1 (point))
                (setq H (char-after)))
              (forward-char))
            (dotimes (_ times)
              (forward-char -1)
              (when (= (char-after) H) (add-to-list 'tops (point))))))
        (dotimes (x times)
          (let ((H 0))
            (goto-char (1- (* L (+ x 2))))
            (dotimes (_ times)
              (setq H (max H (char-after)))
              (when (> (char-before) H) (add-to-list 'p1 (1- (point))))
              (forward-char -1))))
        (dotimes (x times)
          (let ((H 0))
            (goto-char (+ x L 2))
            (dotimes (_ times)
              (setq H (max H (char-after (- (point) L))))
              (when (> (char-after) H) (add-to-list 'p1 (point)))
              (forward-char L))))
        (dotimes (x times)
          (let ((H 0))
            (goto-char (+ x (* L times) 2))
            (dotimes (_ times)
              (setq H (max H (char-after (+ (point) L))))
              (when (> (char-after) H) (add-to-list 'p1 (point)))
              (backward-char L))))
        (dolist (top tops)
          (let ((east 0) (west 0) (north 0) (south 0) top-char score)
            (goto-char top)
            (setq top-char (char-after))
            (while
                (cond
                 ((bolp) nil)
                 ((< (char-before) top-char) (cl-incf east))
                 ((>= (char-before) top-char) (cl-incf east) nil))
              (forward-char -1))
            (goto-char (1+ top))
            (while
                (cond
                 ((eolp) nil)
                 ((< (char-after) top-char) (cl-incf west))
                 ((>= (char-after) top-char) (cl-incf west) nil))
              (forward-char))
            (goto-char top)
            (while
                (cond
                 ((<= (- (point) L) (point-min)) nil)
                 ((< (char-after (- (point) L)) top-char) (cl-incf north))
                 ((>= (char-after (- (point) L)) top-char) (cl-incf north) nil))
              (backward-char L))
            (goto-char top)
            (while
                (cond
                 ((>= (+ (point) L) (point-max)) nil)
                 ((< (char-after (+ (point) L)) top-char) (cl-incf south))
                 ((>= (char-after (+ (point) L)) top-char) (cl-incf south) nil))
              (forward-char L))
            (setq score (* east west north south))
            (if (> score p2) (setq p2 score))))
        (message "Part I:  %s\nPart II: %s" (+ (* 2 (1- L)) (* 2 (- (1- L) 2)) (length p1)) p2)))))

(provide 'day8)
;;; day8.el ends here
