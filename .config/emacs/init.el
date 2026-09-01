;; editor
(setq make-backup-files nil
      create-lockfiles nil)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; ui
(setq inhibit-startup-screen t
      initial-buffer-choice t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq use-dialog-box nil
      use-file-dialog nil
      ring-bell-function 'ignore
      inhibit-startup-echo-area-message (user-login-name))
(fringe-mode 0)
(blink-cursor-mode -1)

(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-when-point-inside-paren t
      show-paren-when-point-in-periphery t
      show-paren-context-when-offscreen 'overlay)
(electric-pair-mode 1)

;; package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; nerd icons
(use-package nerd-icons)

;; evil mode
(use-package evil
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; bindings
(use-package general
  :after evil
  :after recentf
  :config
  (general-evil-setup))

(general-create-definer amra/leader
  :states '(normal visual motion)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

(amra/leader
  "TAB" '(dired-jump :wk "dired")
  
  "f" '(:ignore t :wk "file")
  "ff" #'find-file
  "fs" #'save-buffer
  "fr" #'recentf-open-files

  "b" '(:ignore t :wk "buffer")
  "bb" #'switch-to-buffer
  "bk" #'kill-current-buffer

  "w" '(:ignore t :which-key "window")
  "wh" #'evil-window-left
  "wj" #'evil-window-down
  "wk" #'evil-window-up
  "wl" #'evil-window-right
  "ww" #'evil-window-next
  "wb" #'evil-window-prev
  "ws" #'evil-window-split
  "wv" #'evil-window-vsplit
  "wc" #'evil-window-delete
  "wo" #'delete-other-windows
  "w=" #'balance-windows
  )

;; theming
(use-package adwaita-dark-theme
  :config
  (load-theme 'adwaita-dark t))

;; recent files
(use-package recentf
  :straight nil
  :init
  (setq recentf-max-saved-items 200
	recentf-auto-cleanup 'never)
  :config
  (recentf-mode 1))

;; completion
(use-package eglot
  :straight nil
  :init
  (setq eglot-autoshutdown t
	eglot-sync-connect nil
	eglot-events-buffer-size 0))

(use-package company
  :init
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 2
	company-selection-wrap-around t
	company-tooltip-align-annotations t)
  :config
  (global-company-mode 1))

(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-file 10)
  (add-hook 'completion-at-point-functions #'cape-dabbrev 20))

;; magit
(use-package magit
  :init
  (setq magit-define-global-key-bindings nil
	magit-diff-refine-hunk 'all))

(amra/leader
  "g" '(:ignore t :wk "git")
  "gs" #'magit-status
  "gb" #'magit-blame
  "gl" #'magit-log-current
  "gf" #'magit-file-dispatch
  )
