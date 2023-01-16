(deftheme bmax-light
  "My awesome theme")

(defface my-default-face
  '((t :background "black" :foreground "white"))
  "Default-face"
  :group nil)

(defface bold-face
  '((t :inherit bold))
  "Default-face"
  :group nil)


(let  ((black             "#000000")
       (white              "#ffffff")
       (string-color "#ee44ee")
       (builtin-color "#aa8af7")
       (none               "NONE")
       (bg_dark            "#1f2335")
       (bg                 "#FFeeFF")
       (bg-highlight       "#444444")
       (terminal_black     "#414868")
       (fg                 "#444444")
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
  ;;dddd
  (custom-theme-set-faces
   'bmax-light
   `(default                           ((t (:inherit my-default-face                                     ))))
  ;; `(default                           ((t (:foreground ,fg :background ,bg                              ))))
;;   `(line-number                       ((t (:foreground ,comment                                         ))))
))

(provide-theme 'bmax-light)
