# doom-emacs configuration

Doom emacs is an evil-mode focused community configuration simlar to Spacemacs,
but reportedly much simpler to tweak. It does look like it wants to completely
control the main emacs config dir, requiring a shallow clone of doom-emacs
into `$XDG_CONFIG_HOME/emacs` (if running Emacs 27+).

`chemacs` is a bootloader for different emacs configurations and can be
useful.

TODO: Using the `build-emacs-for-macos` with native comp seems to only create
an Emacs.app package that cannot be symlinked to due to dynamic libraries
being hardcoded? Unclear how to correctly acess the executable.
Cf: https://github.com/jimeh/build-emacs-for-macos/issues/16
