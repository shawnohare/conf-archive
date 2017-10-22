source "$ZPLUGIN_HOME/cache/plugins.zsh" || \
  (echo "No cache file found. Installing plugins." && \
  "$ZPLUGIN_HOME/bin/install" && \
  source "$ZPLUGIN_HOME/cache/plugins.zsh")

