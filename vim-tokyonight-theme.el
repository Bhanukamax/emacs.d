(require 'autothemer)

(autothemer-deftheme
 vim-tokyonight "tokyonight theme"
 ((((class color) (min-colors #xFFFFFF))) ;; We're only concerned with graphical Emacs

  ;; Define our color palette
  (bg_dark            "#1f2335")
  (bg                 "#24283b")
  (bg_highlight       "#292e42")
  (terminal_black     "#414868")
  (fg                 "#c0caf5")
  (fg_dark            "#a9b1d6")
  (fg_gutter          "#3b4261")
  (dark3              "#545c7e")
  (comment            "#565f89")
  (dark5              "#737aa2")
  (blue0              "#3d59a1")
  (blue               "#7aa2f7")
  (cyan               "#7dcfff")
  (blue1              "#2ac3de")
  (blue2              "#0db9d7")
  (blue5              "#89ddff")
  (blue6              "#B4F9F8")
  (blue7              "#394b70")
  (magenta            "#bb9af7")
  (magenta2           "#ff007c")
  (purple             "#9d7cd8")
  (orange             "#ff9e64")
  (yellow             "#e0af68")
  (green              "#9ece6a")
  (green1             "#73daca")
  (green2             "#41a6b5")
  (teal               "#1abc9c")
  (red                "#f7768e")
  (red1               "#db4b4b")
  (magit-add-fg       "#73daca")
  (magit-add-hl-bg    "#2b4146")
  (magit-add-bg       "#222e36")
  (magit-remove-fg    "#f7768e")
  (magit-remove-hl-bg "#7b3b47")
  (magit-remove-bg    "#4a232a")
  )

 ;; Customize faces
 ((default                           (:foreground fg :background bg))
  (cursor                            (:background fg))
  (region                            (:background blue7))
  (mode-line                         (:background fg_gutter))
  (line-number                       (:foreground comment :background bg))
  (highlight                         (:background terminal_black))
  (font-lock-keyword-face            (:foreground purple))
  (font-lock-constant-face           (:foreground green))
  (font-lock-string-face             (:foreground green))
  (font-lock-builtin-face            (:foreground green))
  (font-lock-keyword-face            (:foreground magenta :background bg))
  (font-lock-comment-face            (:foreground comment ))
  ;; Bread crumb


  ;; web mode
  (web-mode-html-tag-bracket-face    (:foreground fg :background bg))
  (web-mode-html-tag-face            (:foreground blue :background bg))
  (web-mode-html-attr-name-face      (:foreground yellow :background bg))
  (web-mode-symbol-face              (:foreground magenta :background bg))
  (default                           (:foreground fg :background bg))

  ;; tree sitter
  (tree-sitter-hl-face:punctuation   (:foreground blue))

  ;; magit
  (magit-diff-context-highlight      (:foreground fg :background bg))
  (magit-diff-removed-highlight      (:foreground magit-remove-fg :background magit-remove-hl-bg))
  (magit-diff-removed                (:foreground magit-remove-fg :background magit-remove-bg))
  (magit-diff-added-highlight        (:foreground magit-add-fg :background magit-add-hl-bg))
  (magit-diff-added                  (:foreground magit-add-fg :background magit-add-bg))
  (magit-diff-hunk-heading-highlight (:foreground bg :background fg))
  (magit-section-highlight           (:background terminal_black))

  (magit-diff-removed                (:background red1))
  (default                           (:foreground fg :background bg))
  (default                           (:foreground fg :background bg))

  ;; Org mode
  (org-level-1                       (:foreground orange))))

(provide-theme 'vim-tokyonight)
