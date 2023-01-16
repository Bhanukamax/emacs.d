;; Packages will be initialized by use-package later.
(setq package-enable-at-startup nil)

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
	        (lambda () (setq gc-cons-threshold (* 2 1000 1000))))

;; Do not resize the frame at this early stage.
(setq frame-inhibit-implied-resize t)

;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; Prevent unwanted runtime builds; packages are compiled ahead-of-time when
;; they are installed and site files are compiled when gccemacs is installed.
(setq comp-deferred-compilation nil
      native-comp-deferred-compilation nil)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
(push '(font . "JetBrainsMono Nerd Font 14") default-frame-alist)
;;(push '(font . "White Rabbit 14") default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; font selection
(setq bmax-font-list '("Iosevka 14"
                       "Iosevka 15"
                       "Iosevka 16"
                       "Iosevka 17"
                       "Iosevka 18"
                       "Iosevka 19"
                       "Iosevka 20"
                       "White Rabbit 14"
                       "White Rabbit 15"
                       "White Rabbit 16"
                       "White Rabbit 17"
                       "Victor Mono Nerd Font 14"
                       "Victor Mono Nerd Font 15"
                       "Victor Mono Nerd Font 16"
                       "Victor Mono Nerd Font 17"
                       "JetBrainsMono Nerd Font 14"
                       "JetBrainsMono Nerd Font 15"
                       "JetBrainsMono Nerd Font 16"
                       "JetBrainsMono Nerd Font 17"))

(defun my/set-font (face)
  (interactive)
  (push `(font . ,face) default-frame-alist)
  (set-face-font 'default face))

(defun my/choose-font (face)
  (interactive (list (completing-read "Choose: " bmax-font-list nil t)))
  (my/set-font face))

(defun my/choose-line-spacing (space)
  (interactive (list (completing-read "Choose: " '("1" "2" "3" "4" "5" "6") nil t)))
  (setq-default line-spacing (string-to-number space)))
