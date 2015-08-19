# Dotfile Dependencies

These dotfiles are not completely self-contained.  For example, they utilize
some external zsh modules.  To ease installation and updating, we have
decided to vendor all external dependencies as git submodules.

## Use

To clone these dotfiles and the dependencies use
`git clone --recursive` as this will initialize the local config file
and tell the dotfiles repo to checkout the appropriate commits.

## Updating

In order to update each submodule to the latest remote commit, we can use
`git submodule update --remote --merge`

## Resources

Using submodules can be a bit daunting at first, and so provide links to
a few useful resources.

- [Pro Git](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
- [Updating submodules](http://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin)
