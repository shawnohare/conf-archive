# zsh optionso
# - Options are primarily referred to by name. 
# These names are case insensitive and underscores are ignored.
# For example, 'allexport' is equivalent to 'A__lleXP_ort'.
# - Comments reference the command below.
# - More information at man zshoptions.

# If a command is a dir name---and not a regular command---cd in. 
setopt autocd 
# Treat the '#', '~' and '^' chars as part of patterns for filename generation, etc.
setopt extendedglob 
# If a pattern for filename generation has no matches, print an error.
setopt nomatch
# Report the status of background jobs immediately. 
setopt notify
