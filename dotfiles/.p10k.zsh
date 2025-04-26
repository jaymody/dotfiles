# temporarily change options
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  # preamble
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # colors
  local grey=245
  local red=1
  local green=2
  local yellow=3
  local blue=4
  local magenta=5
  local cyan=6
  local white=7

  # left segments
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    ###### line 1 ######
    context
    virtualenv
    vcs
    dir
    status
    ###### line 2 ######
    newline
    prompt_char
  )

  # right segments
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # general
  typeset -g POWERLEVEL9K_MODE=ascii
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # prompt_char
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_{VIINS,VICMD,VIVIS}_FOREGROUND=$white

  # status
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$red

  # virtualenv
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$green
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_LEFT_DELIMITER='('
  typeset -g POWERLEVEL9K_VIRTUALENV_RIGHT_DELIMITER=')'
  typeset -g POWERLEVEL9K_VIRTUALENV_CONTENT_EXPANSION='%B${P9K_CONTENT}%b'

  # dir
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$white
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  local anchor_files=(.git .hg .svn)
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=last
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=0
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50

  # context
  typeset -g POWERLEVEL9K_CONTEXT_REMOTE_TEMPLATE="%B%F{$blue}%n%f %F{$red}%m%f"
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%B%F{$blue}%n%f"

  # vcs
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$green
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$magenta
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$red
  # https://github.com/romkatv/powerlevel10k/issues/2859#issuecomment-2832511798
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='%B[${P9K_CONTENT//\%k/${MATCH}%B}]%b'

  # postamble
  (( ! $+functions[p10k] )) || p10k reload
}

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
