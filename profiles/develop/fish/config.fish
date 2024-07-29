if status is-interactive
    # Commands to run in interactive sessions can go here
    type -q zellij && eval (zellij setup --generate-auto-start fish | string collect)
end

fish_add_path $HOME/go/bin /usr/local/sbin

set -gx GOBIN $HOME/go/bin
set -gx EDITOR hx
set -gx FZF_CTRL_T_COMMAND $EDITOR

abbr -a v "$EDITOR"
abbr -a c cargo
abbr -a cat bat
abbr -a df "df -h"
abbr -a du "du -h"
abbr -a g git
abbr -a l "eza -lahgF --group-directories-first"
# --time-style=long-iso
abbr -a ll "eza -F"
# abbr -a exa exa
# j stands for jump
abbr -a j z
abbr -a open xdg-open
abbr -a ps procs

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# don't show any greetings
set fish_greeting ""


# Senstive functions which are not pushed to Github
# It contains work related stuff, some functions, aliases etc...
# source ~/.private.fish


set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths /usr/local/opt/mysql-client/bin $fish_user_paths

# status --is-interactive; and rbenv init - fish | source

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/fatih/Code/google-cloud-sdk/path.fish.inc' ]; . '/Users/fatih/Code/google-cloud-sdk/path.fish.inc'; end
