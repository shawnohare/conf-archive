# Shawn O'Hare's Dotfile Archive
```
 _______  _______  ______   _______ 
(  ____ \(  ___  )(  __  \ (  ___  )
| (    \/| (   ) || (  \  )| (   ) |
| (_____ | |   | || |   ) || (___) |
(_____  )| |   | || |   | ||  ___  |
      ) || |   | || |   ) || (   ) |
/\____) || (___) || (__/  )| )   ( |
\_______)(_______)(______/ |/     \|
                                    

        _             _             _             _          
       / /\          /\ \          /\ \          / /\        
      / /  \        /  \ \        /  \ \____    / /  \       
     / / /\ \__    / /\ \ \      / /\ \_____\  / / /\ \      
    / / /\ \___\  / / /\ \ \    / / /\/___  / / / /\ \ \     
    \ \ \ \/___/ / / /  \ \_\  / / /   / / / / / /  \ \ \    
     \ \ \      / / /   / / / / / /   / / / / / /___/ /\ \   
 _    \ \ \    / / /   / / / / / /   / / / / / /_____/ /\ \  
/_/\__/ / /   / / /___/ / /  \ \ \__/ / / / /_________/\ \ \ 
\ \/___/ /   / / /____\/ /    \ \___\/ / / / /_       __\ \_\
 \_____\/    \/_________/      \/_____/  \_\___\     /____/_/


╔═╗ ╔═╗ ╔╦╗ ╔═╗
╚═╗ ║ ║  ║║ ╠═╣
╚═╝ ╚═╝ ═╩╝ ╩ ╩

  _____     ____     ______       ____    
 / ____\   / __ \   (_  __ \     (    )   
( (___    / /  \ \    ) ) \ \    / /\ \   
 \___ \  ( ()  () )  ( (   ) )  ( (__) )  
     ) ) ( ()  () )   ) )  ) )   )    (   
 ___/ /   \ \__/ /   / /__/ /   /  /\  \  
/____/     \____/   (______/   /__(  )__\ 
                                          
```
There is still much that relies on manual configuration, 
and so I recommend using this repository only as a source of
configuration examples.
# zsh Config Notes

## Manual Configuration 

Assuming that `DOTDIR` is defined somewhere and points to this repository:

- `mkdir $HOME/.zsh`
- Symlink zshenv: `ln -s $DOTDIR/zsh/zshenv $HOME/.zshenv`
- zshenv sets ZDOTDIR to `$HOME/.zsh`
- Symlink dotted versions of config files (e.g., zshrc, zprofile) into `$ZDOTDIR`

## Modules

Each module (zsh file) should be self-contained so that any subset
may be sourced in arbitrary order. The zshrc file simply sources all the
configuration files in this repository. To update the submodules you
can run
```
git submodules update --remote --merge
```
