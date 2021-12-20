######## temp setup ########
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

######## main ########
() {
######## colors ########
local TEXT_COLOR=255

local CONTEXT_BLUE=32
local CONTEXT_SUDO_ORANGE=202
local CONTEXT_REMOTE_PURPLE=126

local ENV_GREEN=35

local GIT_DIRTY_RED=88
local GIT_STAGED_GREEN=30
local GIT_UNSTAGED_PURPLE=92
local GIT_CLEAN_BLUE=25

local CLOUD_PROFILE_ORANGE=166

local DIR_GREY=240
local STATUS_RED=52

local BATTERY_GREEN=70
local BATTERY_ORANGE=208
local BATTERY_RED=160

local KUBERNETES_BLUE=26

local VIM_MODE_WHITE=245



######## setup ########
emulate -L zsh -o extended_glob

# Unset all configuration options. This allows you to apply configuration changes without
# restarting zsh. Edit ~/.p10k.zsh and type `source ~/.p10k.zsh`.
unset -m 'POWERLEVEL9K_*'

# Zsh >= 5.1 is required.
autoload -Uz is-at-least && is-at-least 5.1 || return



######## left ########
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # os_icon                 # os identifier
    context                 # user@hostname

    # asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
    # goenv                   # go environment (https://github.com/syndbg/goenv)
    # jenv                    # java version from jenv (https://github.com/jenv/jenv)
    # luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
    # nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
    # nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
    # plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
    # phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
    # rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    # anaconda                # conda environment (https://conda.io/)

    nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
    # rvm                     # ruby version from rvm (https://rvm.io)
    # fvm                     # flutter version management (https://github.com/leoafarias/fvm)

    # haskell_stack           # haskell version from stack (https://haskellstack.org/)
    # node_version            # node.js version
    # go_version              # go version (https://golang.org)
    # rust_version            # rustc version (https://www.rust-lang.org)
    # dotnet_version          # .NET version (https://dotnet.microsoft.com)
    # php_version             # php version (https://www.php.net/)
    # laravel_version         # laravel php framework version (https://laravel.com/)
    # java_version            # java version (https://www.java.com/)
    # package                 # name@version from package.json (https://docs.npmjs.com/files/package.json)

    dir                     # current directory
    status                  # exit code of the last command
    # newline                 # \n
    # prompt_char             # prompt symbol
)



######## right ########
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    command_execution_time  # duration of the last command

    gcloud                  # google cloud acccount and project (https://cloud.google.com/)
    google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
    # aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    # aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
    # azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
    # kubecontext             # current kubernetes context (https://kubernetes.io/)
    # terraform               # terraform workspace (https://www.terraform.io)

    vcs                     # git status
    background_jobs         # presence of background jobs
    direnv                  # direnv status (https://direnv.net/)

    # nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
    # ranger                  # ranger shell (https://github.com/ranger/ranger)
    # nnn                     # nnn shell (https://github.com/jarun/nnn)
    # vim_shell               # vim shell indicator (:sh)
    # midnight_commander      # midnight commander shell (https://midnight-commander.org/)
    # nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
    # vi_mode                 # vi mode (you don't need this if you've enabled prompt_char)

    vpn_ip                  # virtual private network indicator
    # load                    # CPU load
    # disk_usage              # disk usage
    # ram                     # free RAM
    # swap                    # used swap
    # todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
    # timewarrior             # timewarrior tracking status (https://timewarrior.net/)
    # taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
    # time                    # current time
    # ip                      # ip address and bandwidth usage for a specified network interface
    # public_ip               # public IP address
    # proxy                   # system-wide http/https/ftp proxy
    # battery                 # internal battery
    # wifi                    # wifi speed
    # example                 # example user-defined segment (see prompt_example function below)

    screen                  # GNU screen
)



######## icons ########
typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=
# When set to `moderate`, some icons will have an extra space after them. This is meant to avoid
# icon overlap when using non-monospace fonts. When set to `none`, spaces are not added.
typeset -g POWERLEVEL9K_ICON_PADDING=none
# When set to true, icons appear before content on both sides of the prompt. When set
# to false, icons go after content. If empty or not set, icons go before content in the left
# prompt and after content in the right prompt.
#
# You can also override it for a specific segment:
#
#   POWERLEVEL9K_STATUS_ICON_BEFORE_CONTENT=false
#
# Or for a specific segment in specific state:
#
#   POWERLEVEL9K_DIR_NOT_WRITABLE_ICON_BEFORE_CONTENT=false
typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=

######## font ########
typeset -g POWERLEVEL9K_MODE=nerdfont-complete

######## newline ########
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

######## prompt line connections ########
# Connect left prompt lines with these symbols. You'll probably want to use the same color
# as POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND below.
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%244F╭─'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%244F├─'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%244F╰─'
# Connect right prompt lines with these symbols.
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX='%244F─╮'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%244F─┤'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX='%244F─╯'

######## filler ########
# Filler between left and right prompt on the first prompt line. You can set it to ' ', '·' or
# '─'. The last two make it easier to see the alignment between left and right prompt and to
# separate prompt from command output. You might want to set POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
# for more compact prompt if using using this option.
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
# The color of the filler. You'll probably want to match the color of POWERLEVEL9K_MULTILINE
# ornaments defined above.
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=244
# Start filler from the edge of the screen if there are no left segments on the first line.
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
# End filler on the edge of the screen if there are no right segments on the first line.
typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
fi

######## default background color ########
typeset -g POWERLEVEL9K_BACKGROUND=${DIR_GREY}

######## seperators/ends ########
# Separator between same-color segments on the left.
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%252F\U2502'
# Separator between same-color segments on the right.
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%252F\U2502'
# Separator between different-color segments on the left.
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
# Separator between different-color segments on the right.
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
# The right end of left prompt.
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
# The left end of right prompt.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
# The left end of left prompt.
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
# The right end of right prompt.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
# Left prompt terminator for lines without any segments.
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

######## transient prompt ########
# Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
# when accepting a command line. Supported values:
#
#   - off:      Don't change prompt when accepting a command line.
#   - always:   Trim down prompt when accepting a command line.
#   - same-dir: Trim down prompt when accepting a command line unless this is the first command
#               typed after changing current working directory.
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

######## Instant prompt ########
#   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
#              it incompatible with your zsh configuration files.
#   - quiet:   Enable instant prompt and don't print warnings when detecting console output
#              during zsh initialization. Choose this if you've read and understood
#              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
#   - verbose: Enable instant prompt and print a warning when detecting console output during
#              zsh initialization. Choose this if you've never tried instant prompt, haven't
#              seen the warning, or if you are unsure what this all means.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

######## hot reload ########
# Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
# For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
# can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
# really need it.
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=false



##################################[ dir: current directory ]##################################
# foreground
typeset -g POWERLEVEL9K_DIR_FOREGROUND=${TEXT_COLOR}

# shortening
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=''
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=${TEXT_COLOR}

# anchor (current dir)
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=false

# Don't shorten directories that contain any of these files. They are anchors.
local anchor_files=(
    .bzr
    .citc
    .git
    .hg
    .node-version
    .python-version
    .go-version
    .ruby-version
    .lua-version
    .java-version
    .perl-version
    .php-version
    .tool-version
    .shorten_folder_marker
    .svn
    .terraform
    CVS
    Cargo.toml
    composer.json
    go.mod
    package.json
    stack.yaml
)
typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
# If set to true, remove everything before the last (deepest) subdirectory that contains files
# matching $POWERLEVEL9K_SHORTEN_FOLDER_MARKER. For example, when the current directory is
# /foo/bar/git_repo/baz, prompt will display git_repo/baz. This assumes that /foo/bar/git_repo
# contains a marker (.git) and other directories don't.
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
# Don't shorten this many last directory segments. They are anchors.
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# Shorten directory if it's longer than this even if there is space for it. The value can
# be either absolute (e.g., '80') or a percentage of terminal width (e.g, '50%'). If empty,
# directory will be shortened only when prompt doesn't fit or when other parameters demand it
# (see POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS and POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT below).
# If set to `0`, directory will always be shortened to its minimum length.
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
# When `dir` segment is on the last prompt line, try to shorten it enough to leave at least this
# many columns for typing commands.
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
# When `dir` segment is on the last prompt line, try to shorten it enough to leave at least
# COLUMNS * POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT * 0.01 columns for typing commands.
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
# If set to true, embed a hyperlink into the directory. Useful for quickly
# opening a directory in the file manager simply by clicking the link.
# Can also be handy when the directory is shortened, as it allows you to see
# the full directory that was used in previous commands.
typeset -g POWERLEVEL9K_DIR_HYPERLINK=false

# Enable special styling for non-writable directories.
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
# Show this icon when the current directory is not writable. POWERLEVEL9K_DIR_SHOW_WRITABLE
# above must be set to true for this parameter to have effect.
# typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_VISUAL_IDENTIFIER_EXPANSION='⭐'

# Custom prefix.
# typeset -g POWERLEVEL9K_DIR_PREFIX='%248Fin '

# POWERLEVEL9K_DIR_CLASSES allows you to specify custom icons for different directories.
# It must be an array with 3 * N elements. Each triplet consists of:
#
#   1. A pattern against which the current directory is matched. Matching is done with
#      extended_glob option enabled.
#   2. Directory class for the purpose of styling.
#   3. Icon.
#
# Triplets are tried in order. The first triplet whose pattern matches $PWD wins. If there
# are no matches, the directory will have no icon.
#
# Example:
#
#   typeset -g POWERLEVEL9K_DIR_CLASSES=(
#       '~/work(|/*)'  WORK     '(╯°□°）╯︵ ┻━┻'
#       '~(|/*)'       HOME     '⌂'
#       '*'            DEFAULT  '')
#
# With these settings, the current directory in the prompt may look like this:
#
#   (╯°□°）╯︵ ┻━┻ ~/work/projects/important/urgent
#
# Or like this:
#
#   ⌂ ~/best/powerlevel10k
#
# You can also set different colors for directories of different classes. Remember to override
# FOREGROUND, SHORTENED_FOREGROUND and ANCHOR_FOREGROUND for every directory class that you wish
# to have its own color.
#
#   typeset -g POWERLEVEL9K_DIR_WORK_FOREGROUND=31
#   typeset -g POWERLEVEL9K_DIR_WORK_SHORTENED_FOREGROUND=103
#   typeset -g POWERLEVEL9K_DIR_WORK_ANCHOR_FOREGROUND=39
#
# typeset -g POWERLEVEL9K_DIR_CLASSES=()



##################################[ context: user@hostname ]##################################
# bold username@machine = '%B%n@%m'

# template
local CONTEXT_TEMPLATE='%n'
if [ "$(hostname)" != "jays-mbp" ]; then # TODO: this is less than ideal
    CONTEXT_TEMPLATE="${CONTEXT_TEMPLATE}@%m"
fi

# default
typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=${CONTEXT_BLUE}
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE=${CONTEXT_TEMPLATE}

# root
typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=${BATTERY_RED}
typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%B${CONTEXT_TEMPLATE}"

# remote
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=${CONTEXT_REMOTE_PURPLE}
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_TEMPLATE=${CONTEXT_TEMPLATE}

# remote root
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=${CONTEXT_SUDO_ORANGE}
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_SUDO_TEMPLATE="%B${CONTEXT_TEMPLATE}"

# Don't show context unless running with privileges or in SSH.
# Tip: Remove the next line to always show context.
# typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

# Custom prefix.
# typeset -g POWERLEVEL9K_CONTEXT_PREFIX='%250Fwith '



##########[ gcloud: google cloud acccount and project (https://cloud.google.com/) ]###########
# Google cloud color.
typeset -g POWERLEVEL9K_GCLOUD_BACKGROUND=${CLOUD_PROFILE_ORANGE}

# Show gcloud only when the the command you are typing invokes one of these tools.
# Tip: Remove the next line to always show gcloud.
typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs'

# Google cloud format. Uncomment POWERLEVEL9K_GCLOUD_CONTENT_EXPANSION and edit its value if the
# default is too verbose.
#
#   P9K_GCLOUD_ACCOUNT: the output of `gcloud config get-value account`
#   P9K_GCLOUD_PROJECT: the output of `gcloud config get-value project`
#   ${VARIABLE//\%/%%}: ${VARIABLE} with all occurences of '%' replaced with '%%'.
#
# typeset -g POWERLEVEL9K_GCLOUD_CONTENT_EXPANSION='${P9K_GCLOUD_ACCOUNT//\%/%%}:${P9K_GCLOUD_PROJECT//\%/%%}'
typeset -g POWERLEVEL9K_GCLOUD_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT//\%/%%}'



#####################################[ vcs: git status ]######################################
# Branch icon. Set this parameter to '\uF126 ' for the popular Powerline branch icon.
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=

# Untracked files icon. It's really a question mark, your font isn't broken.
# Change the value of this parameter to show a different icon.
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

# Formatter for Git status.
#
# Example output: master ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
#
# You can edit the function to customize how Git status looks.
#
# VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
# https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
function my_git_formatter() {
    emulate -L zsh

    if [[ -n $P9K_CONTENT ]]; then
        # If P9K_CONTENT is not empty, use it. It's either "loading" or from vcs_info (not from
        # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
        typeset -g my_git_format=$P9K_CONTENT
        return
    fi

    if (( $1 )); then
        # Styling for up-to-date Git status.
        local       meta='%255F'  # grey foreground
        local      clean='%255F'   # green foreground
        local   modified='%255F'  # yellow foreground
        local  untracked='%255F'   # blue foreground
        local conflicted='%255F'  # red foreground

        # local       meta='%250F'  # grey foreground
        # local      clean='%76F'   # green foreground
        # local   modified='%178F'  # yellow foreground
        # local  untracked='%39F'   # blue foreground
        # local conflicted='%196F'  # red foreground
    else
        # Styling for incomplete and stale Git status.
        local       meta='%244F'  # grey foreground
        local      clean='%244F'  # grey foreground
        local   modified='%244F'  # grey foreground
        local  untracked='%244F'  # grey foreground
        local conflicted='%244F'  # grey foreground
    fi

    local res
    local where  # branch or tag
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
        res+="${clean}${POWERLEVEL9K_VCS_BRANCH_ICON}"
        where=${(V)VCS_STATUS_LOCAL_BRANCH}
    elif [[ -n $VCS_STATUS_TAG ]]; then
        res+="${meta}#"
        where=${(V)VCS_STATUS_TAG}
    fi

    # If local branch name or tag is at most 32 characters long, show it in full.
    # Otherwise show the first 12 … the last 12.
    # Tip: To always show local branch name in full without truncation, delete the next line.
    (( $#where > 32 )) && where[13,-13]="…"
    res+="${clean}${where//\%/%%}"  # escape %

    # Display the current Git commit if there is no branch or tag.
    # Tip: To always display the current Git commit, remove `[[ -z $where ]] &&` from the next line.
    [[ -z $where ]] && res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

    # Show tracking branch name if it differs from local branch.
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
        res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
    fi

    # Show the git commit
    # res+=" (${VCS_STATUS_COMMIT:0:5})"

    # ⇣42 if behind the remote.
    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
    # ⇠42 if behind the push remote.
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
    # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    # *42 if have stashes.
    (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
    # 'merge' if the repo is in an unusual state.
    [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
    # ~42 if have merge conflicts.
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    # +42 if have staged changes.
    (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
    # !42 if have unstaged changes.
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    # ?42 if have untracked files. It's really a question mark, your font isn't broken.
    # See POWERLEVEL9K_VCS_UNTRACKED_ICON above if you want to use a different icon.
    # Remove the next line if you don't want to see untracked files at all.
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    # "─" if the number of unstaged files is unknown. This can happen due to
    # POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY (see below) being set to a non-negative number lower
    # than the number of files in the Git index, or due to bash.showDirtyState being set to false
    # in the repository config. The number of staged and untracked files may also be unknown
    # in this case.
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

    typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

# Don't count the number of unstaged, untracked and conflicted files in Git repositories with
# more than this many files in the index. Negative value means infinity.
#
# If you are working in Git repositories with tens of millions of files and seeing performance
# sagging, try setting POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY to a number lower than the output
# of `git ls-files | wc -l`. Alternatively, add `bash.showDirtyState = false` to the repository's
# config: `git config bash.showDirtyState false`.
typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1

# Don't show Git status in prompt for repositories whose workdir matches this pattern.
# For example, if set to '~', the Git repository at $HOME/.git will be ignored.
# Multiple patterns can be combined with '|': '~|~/some/dir'.
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

# Disable the default Git status formatting.
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
# Install our own Git status formatter.
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
# Enable counters for staged, unstaged, etc.
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

# Icon color.
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=76
typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=244
# Custom icon.
# typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION='⭐'
# Custom prefix.
# typeset -g POWERLEVEL9K_VCS_PREFIX='%248Fon '

# Show status of repositories of these types. You can add svn and/or hg if you are
# using them. If you do, your prompt may become slow even when your current directory
# isn't in an svn or hg reposotiry.
typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

# backgrounds
typeset -g POWERLEVEL9K_VCS_BACKGROUND=${GIT_STAGED_GREEN}
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=${GIT_STAGED_GREEN}
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=${GIT_DIRTY_RED}
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=${GIT_UNSTAGED_PURPLE}

# fallback foreground colors
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=255
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=255
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=255



#####################[ virtualenv: python virtual environment (https://docs.python.org/3/library/venv.html) ]#####################
# foreground
typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=${TEXT_COLOR}
# background
typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=${ENV_GREEN}
# If set to "if-different", won't show virtualenv if it's the same as pyenv.
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV="if-different"
# Separate environment name from Python version only with a space.
typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=
# Don't show Python version next to the virtual environment name.
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false



#####################[ anaconda: conda environment (https://conda.io/) ]######################
# foreground
typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND=${TEXT_COLOR}
# background
typeset -g POWERLEVEL9K_ANACONDA_BACKGROUND=${ENV_GREEN}
# delimeter
typeset -g POWERLEVEL9K_ANACONDA_LEFT_DELIMITER='@'

# Don't show Python version next to the anaconda environment name.
typeset -g POWERLEVEL9K_ANACONDA_SHOW_PYTHON_VERSION=false






################[ pyenv: python environment (https://github.com/pyenv/pyenv) ]################
# foreground
typeset -g POWERLEVEL9K_PYENV_FOREGROUND=${TEXT_COLOR}
# background
typeset -g POWERLEVEL9K_PYENV_BACKGROUND=${ENV_GREEN}

# Hide python version if it doesn't come from one of these sources.
typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
# If set to false, hide python version if it's the same as global:
# $(pyenv version-name) == $(pyenv global).
typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false





##########################[ status: exit code of the last command ]###########################
# Enable OK_PIPE, ERROR_PIPE and ERROR_SIGNAL status states to allow us to enable, disable and
# style them independently from the regular OK and ERROR state.
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true

# Status on success. No content, just an icon. No need to show it if prompt_char is enabled as
# it will signify success by turning green.
typeset -g POWERLEVEL9K_STATUS_OK=true
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=70
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION=''

# Status when some part of a pipe command fails but the overall exit status is zero. It may look
# like this: 1|0.
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=70
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION=''

# Status when it's just an error code (e.g., '1'). No need to show it if prompt_char is enabled as
# it will signify error by turning red.
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=${STATUS_RED}
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'

# Status when the last command was terminated by a signal.
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=${STATUS_RED}
# Use terse signal names: "INT" instead of "SIGINT(2)".
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'

# Status when some part of a pipe command fails and the overall exit status is also non-zero.
# It may look like this: 1|0.
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=${TEXT_COLOR}
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=${STATUS_RED}
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'





###################[ command_execution_time: duration of the last command ]###################
# Show duration of the last command if takes longer than this many seconds.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
# Show this many fractional digits. Zero means round to seconds.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
# Execution time color.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=${TEXT_COLOR}
# Duration format: 1d 2h 3m 4s.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
# Custom icon.
# typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=
# Custom prefix.
# typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%250Ftook '





################################################
################### UNEDITED ###################
################################################





#################################[ os_icon: os identifier ]##################################
# OS identifier color.
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=255
  # Custom icon.
  # typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='⭐'





################################[ prompt_char: prompt symbol ]################################
# Transparent background.
typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
# Green prompt symbol if the last command succeeded.
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
# Red prompt symbol if the last command failed.
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
# Default prompt symbol.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
# Prompt symbol in command vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
# Prompt symbol in visual vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
# Prompt symbol in overwrite vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
# No line terminator if prompt_char is the last segment.
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
# No line introducer if prompt_char is the first segment.
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
# No surrounding whitespace.
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=





#######################[ background_jobs: presence of background jobs ]#######################
# Don't show the number of background jobs.
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
# Background jobs color.
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=37
# Custom icon.
# typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='⭐'



###############[ asdf: asdf version manager (https://github.com/asdf-vm/asdf) ]###############
# Default asdf color. Only used to display tools for which there is no color override (see below).
typeset -g POWERLEVEL9K_ASDF_FOREGROUND=66

# There are four parameters that can be used to hide asdf tools. Each parameter describes
# conditions under which a tool gets hidden. Parameters can hide tools but not unhide them. If at
# least one parameter decides to hide a tool, that tool gets hidden. If no parameter decides to
# hide a tool, it gets shown.
#
# Special note on the difference between POWERLEVEL9K_ASDF_SOURCES and
# POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW. Consider the effect of the following commands:
#
#   asdf local  python 3.8.1
#   asdf global python 3.8.1
#
# After running both commands the current python version is 3.8.1 and its source is "local" as
# it takes precedence over "global". If POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW is set to false,
# it'll hide python version in this case because 3.8.1 is the same as the global version.
# POWERLEVEL9K_ASDF_SOURCES will hide python version only if the value of this parameter doesn't
# contain "local".

# Hide tool versions that don't come from one of these sources.
#
# Available sources:
#
# - shell   `asdf current` says "set by ASDF_${TOOL}_VERSION environment variable"
# - local   `asdf current` says "set by /some/not/home/directory/file"
# - global  `asdf current` says "set by /home/username/file"
#
# Note: If this parameter is set to (shell local global), it won't hide tools.
# Tip:  Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SOURCES.
typeset -g POWERLEVEL9K_ASDF_SOURCES=(shell local global)

# If set to false, hide tool versions that are the same as global.
#
# Note: The name of this parameter doesn't reflect its meaning at all.
# Note: If this parameter is set to true, it won't hide tools.
# Tip:  Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_PROMPT_ALWAYS_SHOW.
typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false

# If set to false, hide tool versions that are equal to "system".
#
# Note: If this parameter is set to true, it won't hide tools.
# Tip: Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SHOW_SYSTEM.
typeset -g POWERLEVEL9K_ASDF_SHOW_SYSTEM=true

# If set to non-empty value, hide tools unless there is a file matching the specified file pattern
# in the current directory, or its parent diretory, or its grandparent directory, and so on.
#
# Note: If this parameter is set to empty value, it won't hide tools.
# Note: SHOW_ON_UPGLOB isn't specific to asdf. It works with all prompt segments.
# Tip: Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SHOW_ON_UPGLOB.
#
# Example: Hide nodejs version when there is no package.json and no *.js files in the current
# directory, in `..`, in `../..` and so on.
#
#   typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.js|package.json'
typeset -g POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=

# Ruby version from asdf.
typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=168
# typeset -g POWERLEVEL9K_ASDF_RUBY_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_RUBY_SHOW_ON_UPGLOB='*.foo|*.bar'

# Python version from asdf.
typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=37
# typeset -g POWERLEVEL9K_ASDF_PYTHON_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_PYTHON_SHOW_ON_UPGLOB='*.foo|*.bar'

# Go version from asdf.
typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=37
# typeset -g POWERLEVEL9K_ASDF_GOLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_GOLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

# Node.js version from asdf.
typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=70
# typeset -g POWERLEVEL9K_ASDF_NODEJS_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.foo|*.bar'

# Rust version from asdf.
typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=37
# typeset -g POWERLEVEL9K_ASDF_RUST_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_RUST_SHOW_ON_UPGLOB='*.foo|*.bar'

# .NET Core version from asdf.
typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND=134
# typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_SHOW_ON_UPGLOB='*.foo|*.bar'

# Flutter version from asdf.
typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND=38
# typeset -g POWERLEVEL9K_ASDF_FLUTTER_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_FLUTTER_SHOW_ON_UPGLOB='*.foo|*.bar'

# Lua version from asdf.
typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND=32
# typeset -g POWERLEVEL9K_ASDF_LUA_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_LUA_SHOW_ON_UPGLOB='*.foo|*.bar'

# Java version from asdf.
typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND=32
# typeset -g POWERLEVEL9K_ASDF_JAVA_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_JAVA_SHOW_ON_UPGLOB='*.foo|*.bar'

# Perl version from asdf.
typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND=67
# typeset -g POWERLEVEL9K_ASDF_PERL_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_PERL_SHOW_ON_UPGLOB='*.foo|*.bar'

# Erlang version from asdf.
typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND=125
# typeset -g POWERLEVEL9K_ASDF_ERLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_ERLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

# Elixir version from asdf.
typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND=129
# typeset -g POWERLEVEL9K_ASDF_ELIXIR_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_ELIXIR_SHOW_ON_UPGLOB='*.foo|*.bar'

# Postgres version from asdf.
typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND=31
# typeset -g POWERLEVEL9K_ASDF_POSTGRES_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_POSTGRES_SHOW_ON_UPGLOB='*.foo|*.bar'

# PHP version from asdf.
typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND=99
# typeset -g POWERLEVEL9K_ASDF_PHP_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_PHP_SHOW_ON_UPGLOB='*.foo|*.bar'

# Haskell version from asdf.
typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND=172
# typeset -g POWERLEVEL9K_ASDF_HASKELL_VISUAL_IDENTIFIER_EXPANSION='⭐'
# typeset -g POWERLEVEL9K_ASDF_HASKELL_SHOW_ON_UPGLOB='*.foo|*.bar'

##########[ nordvpn: nordvpn connection status, linux only (https://nordvpn.com/) ]###########
# NordVPN connection indicator color.
typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=39
# Hide NordVPN connection indicator when not connected.
typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=
# Custom icon.
# typeset -g POWERLEVEL9K_NORDVPN_VISUAL_IDENTIFIER_EXPANSION='⭐'



#######################[ direnv: direnv status (https://direnv.net/) ]########################
# Direnv color.
typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=178
# Icon to show when direnv is active.
typeset -g POWERLEVEL9K_DIRENV_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER}'




##########[ nordvpn: nordvpn connection status, linux only (https://nordvpn.com/) ]###########
# NordVPN connection indicator color.
typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=39
# Hide NordVPN connection indicator when not connected.
typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=





#################[ ranger: ranger shell (https://github.com/ranger/ranger) ]##################
# Ranger shell color.
typeset -g POWERLEVEL9K_RANGER_FOREGROUND=178





###########################[ vim_shell: vim shell indicator (:sh) ]###########################
# Vim shell indicator color.
typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=34
# Icon to show when in a vim shell.
typeset -g POWERLEVEL9K_VIM_SHELL_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'





######[ midnight_commander: midnight commander shell (https://midnight-commander.org/) ]######
# Midnight Commander shell color.
typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=178
# Icon to show when in a midnight commander shell.
typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'





###########[ vi_mode: vi mode (you don't need this if you've enabled prompt_char) ]###########
# Text and color for normal (a.k.a. command) vi mode.
typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND=106
# Text and color for visual vi mode.
typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
typeset -g POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND=68
# Text and color for overtype (a.k.a. overwrite and replace) vi mode.
typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_FOREGROUND=172
# Text and color for insert vi mode.
typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=
typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=66






######################################[ ram: free RAM ]#######################################
# RAM color.
typeset -g POWERLEVEL9K_RAM_FOREGROUND=66





######################################[ load: CPU load ]######################################
# Show average CPU load over this many last minutes. Valid values are 1, 5 and 15.
typeset -g POWERLEVEL9K_LOAD_WHICH=5
# Load color when load is under 50%.
typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=66
# Load color when load is between 50% and 70%.
typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=178
# Load color when load is over 70%.
typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=166





################[ goenv: go environment (https://github.com/syndbg/goenv) ]################
# Goenv color.
typeset -g POWERLEVEL9K_GOENV_FOREGROUND=37
# Don't show the current Go version if it's the same as global.
typeset -g POWERLEVEL9K_GOENV_PROMPT_ALWAYS_SHOW=false





##########[ nodenv: node.js version from nodenv (https://github.com/nodenv/nodenv) ]##########
# Nodenv color.
typeset -g POWERLEVEL9K_NODENV_FOREGROUND=$
# Don't show node version if it's the same as global: $(nodenv version-name) == $(nodenv global).
typeset -g POWERLEVEL9K_NODENV_PROMPT_ALWAYS_SHOW=false





##############[ nvm: node.js version from nvm (https://github.com/nvm-sh/nvm) ]###############
# foreground
typeset -g POWERLEVEL9K_NVM_FOREGROUND=${TEXT_COLOR}
# background
typeset -g POWERLEVEL9K_NVM_BACKGROUND=${CLOUD_PROFILE_ORANGE}





############[ nodeenv: node.js environment (https://github.com/ekalinin/nodeenv) ]############
# Nodeenv color.
typeset -g POWERLEVEL9K_NODEENV_FOREGROUND=70
# Don't show Node version next to the environment name.
typeset -g POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false
# Separate environment name from Node version only with a space.
typeset -g POWERLEVEL9K_NODEENV_{LEFT,RIGHT}_DELIMITER=





##############################[ node_version: node.js version ]###############################
# Node version color.
typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=70
# Show node version only when in a directory tree containing package.json.
typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true





#######################[ go_version: go version (https://golang.org) ]########################
# Go version color.
typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=37
# Show go version only when in a go project subdirectory.
typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true





#################[ rust_version: rustc version (https://www.rust-lang.org) ]##################
# Rust version color.
typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=37
# Show rust version only when in a rust project subdirectory.
typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true





###############[ dotnet_version: .NET version (https://dotnet.microsoft.com) ]################
# .NET version color.
typeset -g POWERLEVEL9K_DOTNET_VERSION_FOREGROUND=134
# Show .NET version only when in a .NET project subdirectory.
typeset -g POWERLEVEL9K_DOTNET_VERSION_PROJECT_ONLY=true





#############[ rbenv: ruby version from rbenv (https://github.com/rbenv/rbenv) ]##############
# Rbenv color.
typeset -g POWERLEVEL9K_RBENV_FOREGROUND=168
# Hide ruby version if it doesn't come from one of these sources.
typeset -g POWERLEVEL9K_RBENV_SOURCES=(shell local global)
# If set to false, hide ruby version if it's the same as global:
# $(rbenv version-name) == $(rbenv global).
typeset -g POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false





#######################[ rvm: ruby version from rvm (https://rvm.io) ]########################
# Rvm color.
typeset -g POWERLEVEL9K_RVM_FOREGROUND=168
# Don't show @gemset at the end.
typeset -g POWERLEVEL9K_RVM_SHOW_GEMSET=false
# Don't show ruby- at the front.
typeset -g POWERLEVEL9K_RVM_SHOW_PREFIX=false





###########[ fvm: flutter version management (https://github.com/leoafarias/fvm) ]############
# Fvm color.
typeset -g POWERLEVEL9K_FVM_FOREGROUND=38





################[ terraform: terraform workspace (https://www.terraform.io) ]#################
# Terraform color.
typeset -g POWERLEVEL9K_TERRAFORM_FOREGROUND=38

#[ aws: aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) ]#
# AWS profile color.
typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=208
# POWERLEVEL9K_AWS_CLASSES is an array with even number of elements. The first element
# in each pair defines a pattern against which the current AWS profile gets matched.
# More specifically, it's P9K_CONTENT prior to the application of context expansion (see below)
# that gets matched. If you unset all POWERLEVEL9K_AWS_*CONTENT_EXPANSION parameters,
# you'll see this value in your prompt. The second element of each pair in
# POWERLEVEL9K_AWS_CLASSES defines the context class. Patterns are tried in order. The
# first match wins.
#
# For example, given these settings:
#
#   typeset -g POWERLEVEL9K_AWS_CLASSES=(
#     '*prod*'  PROD
#     '*test*'  TEST
#     '*'       DEFAULT)
#
# If your current AWS profile is "company_test", its class is TEST
# because "company_test" doesn't match the pattern '*prod*' but does match '*test*'.
#
# You can define different colors, icons and content expansions for different classes:
#
#   typeset -g POWERLEVEL9K_AWS_TEST_FOREGROUND=28
#   typeset -g POWERLEVEL9K_AWS_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
#   typeset -g POWERLEVEL9K_AWS_TEST_CONTENT_EXPANSION='> ${P9K_CONTENT} <'
typeset -g POWERLEVEL9K_AWS_CLASSES=(
    # '*prod*'  PROD    # These values are examples that are unlikely
    # '*test*'  TEST    # to match your needs. Customize them as needed.
    '*'       DEFAULT)
# typeset -g POWERLEVEL9K_AWS_DEFAULT_VISUAL_IDENTIFIER_EXPANSION='⭐'

#[ aws_eb_env: aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/) ]#
# AWS Elastic Beanstalk environment color.
typeset -g POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=70





##########[ azure: azure account name (https://docs.microsoft.com/en-us/cli/azure) ]##########
# Azure account name color.
typeset -g POWERLEVEL9K_AZURE_FOREGROUND=32





#############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
# Kubernetes context classes for the purpose of using different colors, icons and expansions with
# different contexts.
#
# POWERLEVEL9K_KUBECONTEXT_CLASSES is an array with even number of elements. The first element
# in each pair defines a pattern against which the current kubernetes context gets matched.
# More specifically, it's P9K_CONTENT prior to the application of context expansion (see below)
# that gets matched. If you unset all POWERLEVEL9K_KUBECONTEXT_*CONTENT_EXPANSION parameters,
# you'll see this value in your prompt. The second element of each pair in
# POWERLEVEL9K_KUBECONTEXT_CLASSES defines the context class. Patterns are tried in order. The
# first match wins.
#
# For example, given these settings:
#
#   typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
#     '*prod*'  PROD
#     '*test*'  TEST
#     '*'       DEFAULT)
#
# If your current kubernetes context is "deathray-testing/default", its class is TEST
# because "deathray-testing/default" doesn't match the pattern '*prod*' but does match '*test*'.
#
# You can define different colors, icons and content expansions for different classes:
#
#   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_FOREGROUND=28
#   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
#   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_CONTENT_EXPANSION='> ${P9K_CONTENT} <'
typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
    # '*prod*'  PROD    # These values are examples that are unlikely
    # '*test*'  TEST    # to match your needs. Customize them as needed.
    '*'       DEFAULT)
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=134
# typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_VISUAL_IDENTIFIER_EXPANSION='⭐'

# Use POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION to specify the content displayed by kubecontext
# segment. Parameter expansions are very flexible and fast, too. See reference:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion.
#
# Within the expansion the following parameters are always available:
#
# - P9K_CONTENT                The content that would've been displayed if there was no content
#                              expansion defined.
# - P9K_KUBECONTEXT_NAME       The current context's name. Corresponds to column NAME in the
#                              output of `kubectl config get-contexts`.
# - P9K_KUBECONTEXT_CLUSTER    The current context's cluster. Corresponds to column CLUSTER in the
#                              output of `kubectl config get-contexts`.
# - P9K_KUBECONTEXT_NAMESPACE  The current context's namespace. Corresponds to column NAMESPACE
#                              in the output of `kubectl config get-contexts`. If there is no
#                              namespace, the parameter is set to "default".
#
# If the context points to Google Kubernetes Engine (GKE) or Elastic Kubernetes Service (EKS),
# the following extra parameters are available:
#
# - P9K_KUBECONTEXT_CLOUD_NAME     Either "gke" or "eks".
# - P9K_KUBECONTEXT_CLOUD_ACCOUNT  Account/project ID.
# - P9K_KUBECONTEXT_CLOUD_ZONE     Availability zone.
# - P9K_KUBECONTEXT_CLOUD_CLUSTER  Cluster.
#
# P9K_KUBECONTEXT_CLOUD_* parameters are derived from P9K_KUBECONTEXT_CLUSTER. For example,
# if P9K_KUBECONTEXT_CLUSTER is "gke_my-account_us-east1-a_my-cluster-01":
#
#   - P9K_KUBECONTEXT_CLOUD_NAME=gke
#   - P9K_KUBECONTEXT_CLOUD_ACCOUNT=my-account
#   - P9K_KUBECONTEXT_CLOUD_ZONE=us-east1-a
#   - P9K_KUBECONTEXT_CLOUD_CLUSTER=my-cluster-01
#
# If P9K_KUBECONTEXT_CLUSTER is "arn:aws:eks:us-east-1:123456789012:cluster/my-cluster-01":
#
#   - P9K_KUBECONTEXT_CLOUD_NAME=eks
#   - P9K_KUBECONTEXT_CLOUD_ACCOUNT=123456789012
#   - P9K_KUBECONTEXT_CLOUD_ZONE=us-east-1
#   - P9K_KUBECONTEXT_CLOUD_CLUSTER=my-cluster-01
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
# Show P9K_KUBECONTEXT_CLOUD_CLUSTER if it's not empty and fall back to P9K_KUBECONTEXT_NAME.
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
# Append the current context's namespace if it's not "default".
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

# Custom prefix.
# typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='%250Fat '





###############################[ public_ip: public IP address ]###############################
# Public IP color.
typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=94





########################[ vpn_ip: virtual private network indicator ]#########################
# VPN IP color.
typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND=81

# When on VPN, show just an icon without the IP address.
# Tip: To display the private IP address when on VPN, remove the next line.
# typeset -g POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=

# Regular expression for the VPN network interface. Run `ifconfig` or `ip -4 a show` while on VPN
# to see the name of the interface.
typeset -g POWERLEVEL9K_VPN_IP_INTERFACE='(wg|(.*tun))[0-9]*'

# If set to true, show one segment per matching network interface. If set to false, show only
# one segment corresponding to the first matching network interface.
# Tip: If you set it to true, you'll probably want to unset POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION.
typeset -g POWERLEVEL9K_VPN_IP_SHOW_ALL=false





#########################[ proxy: system-wide http/https/ftp proxy ]##########################
# Proxy color.
typeset -g POWERLEVEL9K_PROXY_FOREGROUND=68





################################[ battery: internal battery ]#################################
# Show battery in red when it's below this level and not connected to power supply.
typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=160
# Show battery in green when it's charging or fully charged.
typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=70
# Show battery in yellow when it's discharging.
typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=178
# Battery pictograms going from low to high level of charge.
typeset -g POWERLEVEL9K_BATTERY_STAGES=$'\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
# Don't show the remaining time to charge/discharge.
typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false





####################################[ time: current time ]####################################
# Current time color.
typeset -g POWERLEVEL9K_TIME_FOREGROUND=66
# Format for the current time: 09:51:02. See `man 3 strftime`.
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
# If set to true, time will update when you hit enter. This way prompts for the past
# commands will contain the start times of their commands as opposed to the default
# behavior where they contain the end times of their preceding commands.
typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
# Custom icon.
typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=
# Custom prefix.
# typeset -g POWERLEVEL9K_TIME_PREFIX='%250Fat '


# If p10k is already loaded, reload configuration.
# This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
(( ! $+functions[p10k] )) || p10k reload
}



##################################[ screen: screen name ]##################################
function prompt_screen() {
    p10k segment -t "${STY#*.}"
}
# for some reason we need to use the actual numbers and not the vars
typeset -g POWERLEVEL9K_SCREEN_FOREGROUND=255
typeset -g POWERLEVEL9K_SCREEN_BACKGROUND=28



######## end ########
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
