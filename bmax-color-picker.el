
(defun bmax-get-current-column ()
  (string-to-number
   (cadr (split-string  (what-cursor-position) "Column=" nil))))

(defun bmax-get-current-line ()
  (string-to-number
   (car
    (split-string (what-line) "Line " t))))

(defun get-rgb (hex)
  "get rgb values seperately from hex color code"
  (let ((value  (split-string hex "\\|0" t)))
    `((red . ,(concat  (car value) (cadr value)))
      (green . ,(concat  (caddr value) (cadddr value)))
      (blue . ,(concat (car (cddddr value)) (cadr  (cddddr value)))))))


(get-rgb "1a2b3c")

(defun bmax-create-child-frame ()
  (make-frame `((height . 10)
                (width . 40)
                (name . "bmax-color-frame")
                (title . "change colors")
                (parent-frame . ,(selected-frame))
                ;;                (left . ,(bmax-get-current-column))
                ;;              (top . ,(bmax-get-current-line))
                (left . 200)
                (top . 200)
                )))

(framep (selected-frame))


(defun my/get-rgb-at-point ()
  (interactive)
  (let ((my-word
         (thing-at-point 'word))
        (cframe (selected-frame)))
      (bmax-create-child-frame)
    (select-frame-by-name "bmax-color-frame")
  ;; (split-window-below)
    (switch-to-buffer "*bmax-color*")
    ))





(what-column)
;; convert decimal to hex string
(format "%x" 254)
