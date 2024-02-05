(setq package-enable-at-startup nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'tango-dark t)

(setq inhibit-startup-screen t)

(defvar rs/default-font-size 90)
(defvar rs/default-variable-font-size 90)

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height rs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font" :height rs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height rs/default-variable-font-size :weight 'regular)
