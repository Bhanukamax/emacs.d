(require 'package)

;; Basic settings
;; Backup files
(setq make-backup-files nil) ;; stop creating backup~ files
(setq auto-save-default nil) ;; stop creating #autosave# files
(setq create-lockfiles nil)
(setq vc-follow-symlinks nil)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))


(setq inhibit-splash-screen t)         ; hide welcome screen
(package-initialize)
(setq package-native-compile t)
;; remove custom stuff
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

(use-package general :ensure t)
;; Load Org-Babel defined config

(use-package which-key :ensure t)
(setq which-key-idle-delay 0.25)
(which-key-mode)

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  )

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c l f" . 'rustic-format-dwim)
              ("C-c C-c r" . lsp-rename)))

(use-package go-mode
  :ensure
  :bind (:map go-mode-map
              ("C-c l f" . gofmt)))

(use-package lsp-mode
  :ensure
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-M-s-c")
  :hook
  ((web-mode rust-mode lua-mode cpp-mode typescript-mode) . lsp-deferred)
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-enable-hover nil)
  (lsp-idle-delay 0.3)
  (lsp-rust-analyzer-server-display-inlay-hints nil)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints nil)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-diagnostics-enable nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable nil))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package flycheck :ensure)

(use-package company :ensure
  :config
  (setq company-idle-delay 0.0)
  (setq company-minimum-prefix-length 1))


;; Tree sitter
(use-package tree-sitter-langs :defer t)
(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (push '(web-mode . typescript) tree-sitter-major-mode-language-alist)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package paredit :ensure t)
(use-package paren-face :ensure t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

(add-hook 'emacs-lisp-mode-hook       'paren-face-mode)
(add-hook 'lisp-mode-hook             'paren-face-mode)
(add-hook 'lisp-interaction-mode-hook 'paren-face-mode)
(add-hook 'scheme-mode-hook           'paren-face-mode)

(use-package rainbow-mode :ensure t)
(add-hook 'prog-mode-hook       'rainbow-mode)

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")
(setq-default tab-width 2)

(setq-default indent-tabs-mode nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Include projoect name in the frame title
(setq frame-title-format
      '(""
        (:eval
         (let ((project-name (consult--project-name (my/get-prject-dir))))
           (unless (string= "-" project-name)
             (format "[%s] " (upcase  project-name)))))
        "(%b)"))

(defun my/scroll-down (arg)
  "Move cursor down half a screen ARG times."
  (interactive "p")
  (let ((dist (/ (window-height) 2)))
    (next-line dist)))

(defun my/scroll-up (arg)
  "Move cursor up half a screen ARG times."
  (interactive "p")
  (let ((dist (/ (window-height) 2)))
    (previous-line dist)))

(global-set-key [remap scroll-up-command] #'my/scroll-down)
(global-set-key [remap scroll-down-command] #'my/scroll-up)



(defun my/toggle-pop-up ()
  (interactive)
  (setq pop-up-frames (not pop-up-frames))
  (print pop-up-frames)
  )

;; Custom Ibuffer stuff

(setq ibuffer-use-other-window nil)

(defun my/get-project-dir ()
  "get the project directory"
  (interactive)
  (let* ((pr (project-current t))
         (dirs (list (project-root pr))))
    (cdr pr)))

(defun my/ibuffer-project ()
  (interactive)
  (let ((proj-path (car (split-string (my/get-project-dir) "~/" t))))
    (ibuffer)
    (ibuffer-filter-disable)
    (ibuffer-filter-by-filename proj-path)))

(defun my/vterm-ibuffer ()
  (interactive)
  (ibuffer)
  (ibuffer-filter-disable)
  (ibuffer-filter-by-mode 'vterm-mode))

(defun my/ibuffer ()
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (my/vterm-ibuffer)
    (if (eq (project-current) nil)
        (progn (ibuffer) (ibuffer-filter-disable))
      (my/ibuffer-project))))

(use-package magit :ensure t
  :bind (("C-c g w" . magit-worktree)
         ("C-c g g". magit-status))
  :config
  (setq magit-diff-refine-hunk 'all)
  )

(setq blamer-author-formatter " ✎ %s ")
(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 10
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 20)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
;;  (global-blamer-mode 1)
  )


;; multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

  (use-package move-dup :ensure t
    :bind (("M-<up>" . move-dup-move-lines-up)
           ("M-<down>" . move-dup-move-lines-down)
           ("M-p" . move-dup-move-lines-up)
           ("M-n" . move-dup-move-lines-down)
           ("C-M-<up>" . move-dup-duplicate-up)
           ("C-M-<down>" . move-dup-duplicate-down)))

(defun my/load-one-theme (theme)
  (interactive)
  (dolist (theme custom-enabled-themes)
    (disable-theme theme))
  (load-theme theme t))

(defun my/load-theme (&optional selected-theme)
  (interactive)
  (if selected-theme
      (my/load-one-theme selected-theme)
    (progn
      (let (theme)
        (setq theme
              (intern (completing-read
                       "Load custom; theme: "
                       (mapcar #'symbol-name
			                         (custom-available-themes)))))
        (if theme
            (my/load-one-theme theme))))))

;; Themes
;;(use-package catppuccin-theme :ensure t)
;;(use-package nord-theme :ensure t)
;;(use-package nordless-theme :ensure t)
;;(use-package ayu-theme :ensure t)
;;(use-package gruvbox-theme :ensure t)
(use-package gruber-darker-theme :ensure t)
;;(my/load-theme 'gruvbox-dark-hard)
(my/load-theme 'gruber-darker)
;;(my/load-theme 'modus-vivendi)
;;(my/load-theme 'catppuccin)
;; Lua
(use-package lua-mode :ensure t)

;; Dired copy files to split
(setq dired-dwim-target t)
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))


;; yarn pnp shenanigan
(setq enable-local-variables :all)
;; need to add this to the projects with yarn pnp
;; ((web-mode
;;   . ((eval . (let ((project-directory (car (dir-locals-find-file default-directory))))
;;                (setq
;;                 lsp-clients-typescript-server-args `("--tsserver-path" ,(concat project-directory "v4/.yarn/sdks/typescript/bin/tsserver") "--stdio")
;;                 lsp-clients-typescript-npm-location   (concat project-directory "v4/.yarn/sdks/typescript")
;;                 lsp-eslint-node-path (concat project-directory "v4/.yarn/sdks/")
;;                 flycheck-javascript-eslint-executable (concat project-directory "v4/.yarn/sdks/eslint/bin/eslint.js")))))))




;; web
(use-package emmet-mode :ensure t)
(defun my/web-mode-hook()
  "Hooks for web mode"
  (print "entered web mode")
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
;;  (emmet-mode)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-indentation nil)
  (setq web-mode-markup-indent-offset 2)
  (display-fill-column-indicator-mode t)
  (set-fill-column 100))

(use-package web-mode :ensure t
  :bind
  (("C-c l f" . lsp-eslint-apply-all-fixes))
  :hook
  ((web-mode . lsp-deferred)
   (web-mode . my/web-mode-hook)
   ;; (web-mode . setup-tide-mode)
   ))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(add-hook 'find-file-hook #'my-find-file-hook)
(defun my-find-file-hook ()
  (when (and (stringp buffer-file-name)
             (or
              (string-match "\\.html\\'" buffer-file-name)
              (string-match "\\.tsx\\'" buffer-file-name)
              (string-match "\\.jsx\\'" buffer-file-name)))
    (emmet-mode)))

(add-to-list 'auto-mode-alist '("\\.keymap\\'" . c-mode))

(add-hook 'html-mode-hook #'emmet-mode)

;; LSP Hooks
;;(add-hook 'web-mode-hook #'lsp)
;;(add-hook 'rust-mode-hook #'lsp)
;;(add-hook 'lua-mode-hook #'lsp)
;;(add-hook 'c-mode-hook #'lsp)
;; (add-hook 'cpp-mode-hook #'lsp)
(add-hook 'web-mode-hook #'my/web-mode-hook)
(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'my/web-mode-hook)

;;(use-package dap-mode :ensure t)

(with-eval-after-load 'lsp-mode
;;  (require 'dap-chrome)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (yas-global-mode))

(use-package consult :ensure t)

(defvar bmax-x-5-map (let ((map (make-sparse-keymap))) (set-keymap-parent map ctl-x-5-map))
  "Extended boon command map.

\\{boon-x-map}")
(fset 'bmax-x-5-map bmax-x-5-map)

(use-package swiper :ensure t)
(use-package noccur :ensure t)

;; File tree
(use-package neotree :ensure t
  :bind (([f8] . neotree-toggle)
         ([f4] . neotree-toggle)
         ([f5] . neotree-find)))

;; Open line like vial
(defun my/open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (forward-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))


;; Behave like vi's O command
(defun my/open-previous-line (arg)
  "Open a new line before the current one.
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(defun my/reload-config ()
	(interactive)
	(load-file (concat user-emacs-directory "init.el")))

(defun my/project-ripgrep ()
  (interactive)
  (let ((my-word
         (thing-at-point 'word))
        (consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --line-number . --hidden")
        )
    (consult-ripgrep nil my-word)
    ))

(defun my/project-ripgrep-region (start end)
  (interactive)
  (let ((term (buffer-substring start end))
        (consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --line-number . --hidden"))
    (consult-ripgrep nil term)))

(defun my/project-ripgrep-dwim ()
  (interactive)
  (if (region-active-p)
      (my/project-ripgrep-region (region-beginning) (region-end))
    (my/project-ripgrep)))

(defun my/vim* ()
  (interactive)
  (let ((my-word
         (thing-at-point 'word)))
    (swiper my-word)))

(defun my/vim*-region (start end)
  (interactive)
  (let ((term (buffer-substring start end)))
    (print term)
    (swiper term)))

(defun my/vim*-dwim ()
  (interactive)
  (if (region-active-p)
      (my/vim*-region (region-beginning) (region-end))
    (my/vim*)))


(defun my/window-rotate ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))

(defun my/split-v ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun my/split-h ()
  (interactive)
  (split-window-below)
  (other-window 1))

(use-package shell-here
  :ensure t
  :config
  (define-key (current-global-map) "\C-c!" 'shell-here)
  )

(global-set-key (kbd "C-`") (kbd "C-- C-u C-c !"))

(defun my/get-project-dir ()
  "get the project directory"
  (interactive)
  (let* ((pr (project-current t))
         (dirs (list (project-root pr))))
    (cdr pr)))

(defun my/ibuffer-project ()
  (interactive)
  (let ((proj-path (car (split-string (my/get-project-dir) "~/" t))))
    (ibuffer)
    (ibuffer-filter-disable)
    (ibuffer-filter-by-filename proj-path)))

(use-package compile
  :bind (:map compilation-mode-map
              ("r" . compile)))

(use-package project
  :ensure t
  :bind (("C-M-s-p" . project-find-file)))




(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))
;; Modes

(winner-mode 1)

(global-company-mode 1)
(global-display-line-numbers-mode 1)

;; (fido-vertical-mode)
(delete-selection-mode t)
(repeat-mode t)


(cl-defmacro ebn/def-repeat-map (name &key keys exit-with)
  (declare (indent 0))
  (let ((def-repeat-map-result nil))
    (when exit-with
      (push `(define-key ,name ,(kbd exit-with) #'keyboard-quit)
	    def-repeat-map-result))
    (dolist (key (map-pairs keys))
      (push `(define-key ,name ,(car key) ,(cdr key))
	    def-repeat-map-result)
      (push `(put ,(cdr key) 'repeat-map ',name)
	    def-repeat-map-result))
    `(progn
       (defvar ,name (make-sparse-keymap))
       ,@def-repeat-map-result)))

(use-package repeat
  :ensure nil
  :init
  (repeat-mode 1)
  :config
  ;; (ebn/def-repeat-map to-word-repeat-map
	;; 	      :keys ("f" #'forward-to-word
	;; 		           "b" #'backward-to-word)
	;; 	      :exit-with "RET")

  ;; (ebn/def-repeat-map forward-word-repeat-map
	;; 	      :keys ("f" #'forward-word
	;; 		           "b" #'backward-word)
	;; 	      :exit-with "RET")

  ;; (ebn/def-repeat-map capitalize-word-repeat-map
	;; 	      :keys ("c" #'capitalize-word))

  ;; (ebn/def-repeat-map downcase-word-repeat-map
	;; 	      :keys ("l" #'downcase-word))

  (ebn/def-repeat-map mark-word-repeat-map
		                  :keys ("@" #'mark-word)
                      :exit-with "RET")

  (ebn/def-repeat-map mark-sexp-repeat-map
		                  :keys ("C-@" #'mark-sexp)
                      :exit-with "RET")

  (ebn/def-repeat-map mark-sexp-repeat-map
		                  :keys ([return] #'mark-sexp
                             "S-2" #'mark-sexp))

  :bind (:map isearch-mode-map
	      ("<down>" . #'isearch-repeat-forward)
	      ("<up>" . #'isearch-repeat-backward)))



;; Replace stuff

(defvar my/re-builder-positions nil
    "Store point and region bounds before calling re-builder")
  (advice-add 're-builder
              :before
              (defun my/re-builder-save-state (&rest _)
                "Save into `my/re-builder-positions' the point and region
positions before calling `re-builder'."
                          (setq my/re-builder-positions
                                (cons (point)
                                      (when (region-active-p)
                                        (list (region-beginning)
                                              (region-end)))))))
(defun reb-replace-regexp (&optional delimited)
  "Run `query-replace-regexp' with the contents of re-builder. With
non-nil optional argument DELIMITED, only replace matches
surrounded by word boundaries."
  (interactive "P")
  (reb-update-regexp)
  (let* ((re (reb-target-binding reb-regexp))
         (replacement (query-replace-read-to
                       re
                       (concat "Query replace"
                               (if current-prefix-arg
                                   (if (eq current-prefix-arg '-) " backward" " word")
                                 "")
                               " regexp"
                               (if (with-selected-window reb-target-window
                                     (region-active-p)) " in region" ""))
                       t))
         (pnt (car my/re-builder-positions))
         (beg (cadr my/re-builder-positions))
         (end (caddr my/re-builder-positions)))
    (with-selected-window reb-target-window
      (goto-char pnt) ; replace with (goto-char (match-beginning 0)) if you want
                      ; to control where in the buffer the replacement starts
                      ; with re-builder
      (setq my/re-builder-positions nil)
      (reb-quit)
      (query-replace-regexp re replacement delimited beg end))))

(require 're-builder)
(define-key reb-mode-map (kbd "RET") #'reb-replace-regexp)
(define-key reb-lisp-mode-map (kbd "RET") #'reb-replace-regexp)
(global-set-key (kbd "C-M-%") #'re-builder)

;; end of replace stuff


;; Scala
(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(use-package lsp-metals
  :ensure t
  :custom
  ;; Metals claims to support range formatting by default but it supports range
  ;; formatting of multiline strings only. You might want to disable it so that
  ;; emacs can use indentation provided by scala-mode.
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  :hook (scala-mode . lsp))

;; Graphql
(use-package graphql-mode
  :ensure t)

;; COMPILE
(require 'ansi-color)

;; GRPC
(use-package protobuf-mode :ensure t)

(defun rc/colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'rc/colorize-compilation-buffer)


(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-M-s-k" . centaur-tabs-move-current-tab-to-left)
  ("C-M-s-j" . centaur-tabs-move-current-tab-to-right)
  ("M-s-k" . centaur-tabs-backward)
  ("M-s-j" . centaur-tabs-forward))


;; copit
(use-package editorconfig :ensure t
  ) ;; required for copilote mode
(load "~/copilot.el/copilot.el")


(add-hook 'prog-mode-hook 'copilot-mode)

(setq ispell-program-name "aspell")
;; You could add extra option "--camel-case" for camel case code spell checking if Aspell 0.60.8+ is installed
;; @see https://github.com/redguardtoo/emacs.d/issues/796
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=16"))

(use-package wucuo :ensure t)
;; my prog mode hook
;; define a function to be called when prog-mode-hook is run
;; the hook will only run copilot mode and flyspell-prog-mode for now
(defun my/prog-mode-hook ()
  "My prog mode hook."
  (copilot-mode)
  (wucuo-start))

(add-hook 'prog-mode-hook 'my/prog-mode-hook)

(defun my/c-mode-hook ()
  (copilot-mode -1))

(add-hook 'c-mode-hook 'my/c-mode-hook)

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)

;; load proj-marks package from home directory
(load "~/proj-marks/proj-marks.el") ;; this is not needed
(load "~/proj-marks/proj-marks2.el")
;;(require 'proj-marks)

;; load harpoon data on buffer change
(defun my-project-change-hook ()
  "Function to run when the current project is changed."
  (bmax/harpoon-load))

;; call the hook when buffer list is updated
(add-hook 'buffer-list-update-hook 'my-project-change-hook)


;; clang-format
(setq clang-format-style "llvm")
(setq clang-format-style "{PointerAlignment: Left}")
(use-package clang-format
  :ensure t
  :bind (:map c-mode-base-map
              ("C-c C-f" . clang-format-region)
              ("C-c l f" . clang-format-buffer)))


(use-package emacs
  :bind (
	       ("C-<return>" . mark-sexp)
         ("C-x C-b" . my/ibuffer-project)
         ("C-x 3" . my/split-v)
         ("C-x 2" . my/split-h)
	       ("C-4" . my/project-ripgrep-dwim)
	       ("C-9" . revert-buffer)
	       ("M-5" . bmax-x-5-map)
	       ("C-5" . my/vim*-dwim)
         ("C-o" . my/open-next-line)
         ("C-S-o" . my/open-previous-line)
         ("C-c l t" . my/load-theme)
         ("C-M-s-r" . my/window-rotate)
         ("C-c l b" . compile)
         ("C-c l c" . my/reload-config)
         ("C-c h a" . bmax/harpoon-add)
         ("C-c h o" . bmax/harpoon-open-bookmark)
         ("C-c h h" . bmax/harpoon-pop-window)
         ("C-c h d" . bmax/harpoon-delete-bookmark)))


;; (use-package elgot
;;   :ensure t)
;; (require 'eglot)
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; emacs29 stuff
(pixel-scroll-precision-mode)
