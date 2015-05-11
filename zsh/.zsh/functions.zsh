##
# ITERM 2 SETUP
##
# based off of https://gist.github.com/capotej/4320967
# for displaying more info in iterms title/tab bars

function set_title_tab {
    function settab   {
        # file settab  -- invoked only if iTerm or Konsole is running
        #  Set iterm window tab to current directory and penultimate directory if the
        #  shell process is running.  Truncate to leave the rightmost $rlength characters.
        #  Use with functions settitle (to set iterm title bar to current directory)
        #  and chpwd
    if [[ $TERM_PROGRAM == iTerm.app && -z "$KONSOLE_DCOP_SESSION" ]];then
      # The $rlength variable prints only the 20 rightmost characters. Otherwise iTerm truncates
      # what appears in the tab from the left.
        # Chage the following to change the string that actually appears in the tab:
          tab_label="$PWD:h:t/$PWD:t"
          rlength="20"   # number of characters to appear before truncation from the left
                echo -ne "\e]1;${(l:rlength:)tab_label}\a"
    else
        # For KDE konsole tabs
        # Chage the following to change the string that actually appears in the tab:
          tab_label="$PWD:h:t/$PWD:t"
          rlength="20"   # number of characters to appear before truncation from the left
            # If we have a functioning KDE console, set the tab in the same way
            if [[ -n "$KONSOLE_DCOP_SESSION" && ( -x $(which dcop)  )  ]];then
                    dcop "$KONSOLE_DCOP_SESSION" renameSession "${(l:rlength:)tab_label}"
            else
                : # do nothing if tabs don't exist
            fi
    fi
  }
 
    function settitle   {
    # Function "settitle"  --  set the title of the iterm title bar. use with chpwd and settab
    # Change the following string to change what appears in the Title Bar label:
      title_lab=$HOST:r:r::$PWD
        # Prints the host name, two colons, absolute path for current directory
      # Change the title bar label dynamically:
      echo -ne "\e]2;[zsh]   $title_lab\a"
  }
  # Set tab and title bar dynamically using above-defined functions
    function title_tab_chpwd { settab ; settitle }
    # Now we need to run it:
      title_tab_chpwd
  # Set tab or title bar label transiently to the currently running command
  if [[ "$TERM_PROGRAM" == "iTerm.app" ]];then
    function title_tab_preexec {  echo -ne "\e]1; $(history $HISTCMD | cut -b7- ) \a"  }
    function title_tab_precmd  { settab }
  else
    function title_tab_preexec {  echo -ne "\e]2; $(history $HISTCMD | cut -b7- ) \a"  }
    function title_tab_precmd  { settitle }
  fi
  # Use reserved named arrays instead of special functions if the ZSH version is 4.3.4 or above
    typeset -ga preexec_functions
    preexec_functions+=title_tab_preexec
    typeset -ga precmd_functions
    precmd_functions+=title_tab_precmd
    typeset -ga chpwd_functions
    chpwd_functions+=title_tab_chpwd
  # Otherwise we need to do this for older versions of zsh:
    if [[ $ZSH_VERSION < 4.3.4 ]];then
      function preexec { $preexec_functions }
      function precmd  { $precmd_functions  }
      function  chpwd  { $chpwd_functions   }
    fi
}
 
 
set_title_tab

