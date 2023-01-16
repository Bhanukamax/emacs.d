(deftheme bmax-day
  "Created 2022-08-23.")

(custom-theme-set-faces
 'bmax-day
 '(default ((t ( :family "VictorMono Nerd Font"
                 :foundry "UKWN"
                 :width normal
                 :height 152
                 :weight normal
                 :slant normal
                 :underline nil
                 :overline nil
                 :extend nil
                 :strike-through nil
                 :box nil
                 :inverse-video nil
                 :foreground "#202020"
                 :background "#ffffff"
                 :stipple nil
                 :inherit nil))))

 '(cursor ((t (:background "magenta"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "#b6532f"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:foreground "#008858"))))
 '(highlight ((t (:foreground "#000000" :background "#aaeccf"))))
 '(region ((t (:extend t :background "#bfefff"))))
 '(shadow ((t (:foreground "#70627f"))))
 '(secondary-selection ((t (:extend t :foreground "#000000" :background "#b4cfff"))))
 '(trailing-whitespace ((t (:foreground "#000000" :background "#ff8f88"))))
 '(font-lock-builtin-face ((t (:foreground "#ba35af" :inherit (bold)))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#a65f6a" :inherit (italic)))))
 '(font-lock-constant-face ((t (:foreground "#065fff"))))
 '(font-lock-doc-face ((t (:foreground "#506fa0" :inherit (italic)))))
 '(font-lock-doc-markup-face ((t (:inherit (font-lock-constant-face)))))
 '(font-lock-function-name-face ((t (:foreground "#cf25aa"))))
 '(font-lock-keyword-face ((t (:inherit bold :foreground "dark violet"))))
 '(font-lock-negation-char-face ((t (:inherit (bold)))))
 '(font-lock-preprocessor-face ((t (:foreground "#e00033"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#217a3c" :inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#e00033" :inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#4250ef"))))
 '(font-lock-type-face ((t (:foreground "#008858"))))
 '(font-lock-variable-name-face ((t (:foreground "#1f77bb"))))
 '(font-lock-warning-face ((t (:foreground "#b6532f"))))

 '(button ((t (:underline (:color "#cecfff" :style line) :foreground "#065fff"))))
 '(link ((t (:underline (:color "#cecfff" :style line) :foreground "#065fff"))))
 '(link-visited ((t (:underline (:color "#cecfff" :style line) :foreground "#ba35af"))))
 '(fringe ((t nil)))
 '(header-line ((t (:background "#efefef"))))
 '(tooltip ((t (:foreground "#000000" :background "#dbdbdb"))))

 ;; Mode line
 '(mode-line ((t (:foreground "#151515" :background "#b7c7ff"))))
 '(mode-line-buffer-id ((t (:inherit (bold)))))
 '(mode-line-emphasis ((t (:inherit (bold-italic)))))
 '(mode-line-highlight ((t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:foreground "#70627f" :background "#dbdbdb"))))

 '(isearch ((t (:foreground "#000000" :background "#fac200"))))
 '(isearch-fail ((t (:foreground "#000000" :background "#ff8f88"))))
 '(lazy-highlight ((t (:foreground "#000000" :background "#cbcfff"))))
 '(match ((t (:foreground "#000000" :background "#dbdbdb"))))
 '(next-error ((t (:inherit (region)))))
 '(flycheck-error-list-error-message ((t (:forground "#55ff66"))))
  '(flycheck-error-< ((t (:forground "#55ff66"))))
 '(query-replace ((t (:foreground "#000000" :background "#ff8f88")))))

(provide-theme 'bmax-day)
