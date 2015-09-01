# Vendored dependencies 

We vendor certain dependencies because there was not a clear easiest
way to automate installation.

## Hack Font
On Mon, 31 Aug 2015 there was no clear way to automate the installation of
the Hack font (which is not included in the Powerline fonts repo),
and so the `installfonts.sh` in this repo's `bin/` directory
will copy the vendored fonts to the appropriate location.
