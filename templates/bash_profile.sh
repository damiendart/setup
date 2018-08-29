# {{ ansible_managed }}
#
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE file.


export EDITOR="vim"
export GEM_HOME="$HOME/.gem"
export NPM_CONFIG_PREFIX="$HOME/.npm"
export PATH="$PATH:$GEM_HOME/bin:$NPM_CONFIG_PREFIX/bin"


git config --global core.excludesfile "$HOME/.gitignore"
git config --global user.name "{{ full_name }}"
git config --global user.email "{{ EMAIL_ADDRESS }}"
cat > "$HOME/.gitignore" <<GITIGNORE
*.swp
node_modules
GITIGNORE
