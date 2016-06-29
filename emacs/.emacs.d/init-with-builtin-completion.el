(use-package evil
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)

    (use-package evil-commentary
      :config
      (evil-commentary-mode))

    ;; leader shortcuts
    ;; This has to be before we invoke evil-mode due to:
    ;; https://github.com/cofi/evil-leader/issues/10
    (use-package evil-leader
      :init (global-evil-leader-mode)
      :config
      (progn
        (setq evil-leader/in-all-states t)
        (evil-leader/set-leader "<SPC>")
        (evil-leader/set-key
          "kb" 'kill-buffer
          "Kb" 'kill-this-buffer
          "o" 'occur
          "T" 'eshell
          "wd" 'delete-window
          "wo" 'delete-other-windows
          "ws" 'split-window-below
          "wh" 'split-window-horizontally
          "wv" 'split-window-vertically
          "ww" 'other-window
          )))

    ;; boot evil by default
    (evil-mode 1))
  :config
  (progn
    ;; Enter ex-mode using smex
    ;; (define-key evil-ex-map "e " 'ido-find-file)
    ;; (define-key evil-ex-map "e " 'helm-find-files)
    ;; (define-key evil-ex-map "b " 'ido-switch-buffer)
    ;; (define-key evil-ex-map "x" 'smex)

    ;; recover emacs key bindings in motion state
    (my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
    (my-move-key evil-motion-state-map evil-normal-state-map " ")

    ;; esc should always quit: http://stackoverflow.com/a/10166400/61435
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)))

