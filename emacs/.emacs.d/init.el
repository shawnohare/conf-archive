(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Define file the customize UI writes to.
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

;; Prefer spaces to tabs.
;; (setq-default indent-tabs-mode nil)

;; Increase garbage collection threshold
(setq gc-cons-threshold 20000000)
(show-paren-mode)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  ;; f(f, t, k), (define-key t k (lookup-key f k)), (define-key f k nil)
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))

(use-package fzf)
(use-package pt)
(use-package which-key)

;; Builtin package to show line numbers.
(use-package linum
  :config
  (global-linum-mode))

(use-package recentf
  :config
  (recentf-mode 1))
;; (load "~/.emacs.d/init-with-ido.el")
;; (load "~/.emacs.d/init-with-ivy.el")
(load "~/.emacs.d/init-with-helm.el")
;; (load "~/.emacs.d/init-with-builtin-completion.el")

;; TODO
;; - Consider using general instead of evil-leader
;; - Consider using hydra for things like helm?
;; - Try to pick helm, ivy, or ido.
;; - which-key
