export DOTFILES_DIR="$(dirname "$(dirname "$(realpath "${(%):-%N}")")")"

function command_exists {
    command -v "$1" >/dev/null 2>&1
}

function source_if_exists {
    [ -f "$1" ] && source "$1"
}

function prepend_to_path {
    [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH";
}

function setup_zsh {
    # editor
    if command_exists nvim; then
        export EDITOR=nvim
    elif command_exists vim; then
        export EDITOR=vim
    else
        export EDITOR=vi
    fi

    # use emacs keybindings
    bindkey -e

    # path
    export PATH=$PATH:${HOME}/bin
    export PATH=$PATH:${HOME}/.bin
    export PATH=$PATH:${HOME}/.local/bin

    # history
    export HISTSIZE=1024000
    export SAVEHIST=1024000

    # make ctrl-p and ctrl-n go up/down the history given the current prefix
    autoload -U up-line-or-beginning-search
    autoload -U down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^P" up-line-or-beginning-search
    bindkey "^N" down-line-or-beginning-search

    # zsh plugins
    source_if_exists "$DOTFILES_DIR/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source_if_exists "$DOTFILES_DIR/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    source_if_exists "$DOTFILES_DIR/zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme"
    source_if_exists "$HOME/.p10k.zsh"
}

function setup_tools {
    ### zoxide ###
    if command_exists zoxide; then
        eval "$(zoxide init zsh)"
    fi

    ### direnv ###
    export DIRENV_LOG_FORMAT=
    if command_exists direnv; then
        eval "$(direnv hook zsh)"
    fi

    ### ocaml ###
    [[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null

    ### rust ###
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

    ### docker ###
    export PATH="/Applications/Docker.app/Contents/Resources/bin:${PATH}"
}

function setup_fzf {
    prepend_to_path $HOME/.fzf/bin

    if command_exists fzf; then
        source <(fzf --zsh)

        local ignore_dirs=".git,node_modules,.opam,.cache,target,_build"

        local cpy_cmd="xclip -selection clipboard"
        if command -v pbcopy &> /dev/null; then cpy_cmd="pbcopy" fi
        export FZF_CTRL_R_OPTS="--bind 'ctrl-y:execute-silent(echo -n {2..} | $cpy_cmd)+abort'"

        # TODO: older vesions of fzf don't support [become], maybe there's a portable alternative?
        # https://github.com/junegunn/fzf/issues/3650#issuecomment-1973846496
        export FZF_CTRL_T_OPTS="
        --walker-skip $ignore_dirs
        --preview 'batcat --color=always {} || bat --color=always {} || cat {}'
        --bind 'ctrl-y:become(nvim {} > /dev/tty)'
        "

        export FZF_ALT_C_OPTS="
        --walker-skip $ignore_dirs
        --preview 'tree -C {} || ls -1'
        "
    fi
}

function main {
    # homebrew
    if test -f "/opt/homebrew/bin/brew"; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # powerlevel10k instant prompt, should go near the top of zshrc
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    setup_zsh
    setup_tools
    setup_fzf

    source "${HOME}/.functions"
    source "${HOME}/.aliases"
}

main
