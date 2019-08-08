# Only executed by login shells
# NOT executed by shells created within tmux

export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Setting PATH for Python 2.7
# The original version is saved in .profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

# Add dotnet tools to path if installed
if [ -d /usr/local/share/dotnet ]; then
  export PATH="/usr/local/share/dotnet:~/.dotnet/tools:${PATH}"
fi

# Also source .bashrc for terminal shells
source ~/.bashrc
