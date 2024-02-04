(defvar rs/default-font-size 150)
(defvar rs/default-variable-font-size 150)

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height rs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font" :height rs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height rs/default-variable-font-size :weight 'regular)
