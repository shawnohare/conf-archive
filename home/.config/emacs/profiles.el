;; (defvar config-home (expand-file-name "emacs" (or (getenv "XDG_CONFIG_HOME") "~/.config")))

;; profiles-home is defined in chemacs init.el
;; (message "profiles-home: %s" profiles-home)

;; FIXME: With the chemacs version of init.el, the user dirs appear to need to
;; be hardcoded.
(
    ("default" . (
        ; (user-emacs-directory . (expand-file-name "default" (getenv "EMACS_PROFILES_HOME")))
        (user-emacs-directory . "~/.config/emacs/profiles/default")
    ))
    ("spacemacs" . (
        ; (user-emacs-directory . (expand-file-name "spacemacs" (getenv "EMACS_PROFILES_HOME")))
        (user-emacs-directory . "~/.config/emacs/profiles/spacemacs")
        (server-name . "spacemacs")
        (custom-file . "~/.config/spacemacs/custom.el")
        ;; (env . (("SPACEMACSDIR" . "~/.spacemacs.d"))))
    ))
    ("doom" . (
        ; (user-emacs-directory . (expand-file-name "doom" (getenv "EMACS_PROFILES_HOME")))
        (user-emacs-directory . "~/.config/emacs/profiles/doom")
        (server-name . "doom")
        ;; (custom-file . "~/.config/doom/custom.el")
    ))
)

