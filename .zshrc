# The following lines were added by compinstall

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/Users/jeisenberg/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## EXPORTS
# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export LESS='-F -X --ignore-case --raw-control-chars'
export EDITOR='vim'
# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C

# GitHub token for homebrew (API limits)
export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.gh_api_token)

## END EXPORTS

## ALIASES
# Same as above, but in long listing format
alias ll='ls -GFhl'

# List octal permissions
alias lsoctal='stat -f "%A %N"'

# Weather
alias weather="curl wttr.in/baltimore"
## END ALIASES

## FUNCTIONS

# Store previous command in pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# Open fuzzy find in vim
function vopen() {
  vim `rg -g "$1" --files`
}

## END FUNCTIONS

## HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
## END HISTORY

## PROMPT
function git_prompt_info {
  local ref=$(=git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(=git status 2> /dev/null)"

  if [[ -f .git/MERGE_HEAD ]]; then
    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
    else
      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" %{$fg[blue]%}!%{$reset_color%}"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" %{$fg[red]%}!%{$reset_color%}"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" %{$fg[yellow]%}*%{$reset_color%}"
  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$fg_bold[green]%}/${ref#refs/heads/}%{$reset_color%}$gitstatus"
  fi
}

PROMPT=' %~%<< $(git_prompt_info)${PR_BOLD_WHITE}>%{${reset_color}%} '
## END PROMPT

## OPTIONS

# Don't add dups to history
setopt  HIST_IGNORE_ALL_DUPS
# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS
# Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY
# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD 
# Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt PROMPT_SUBST

## END OPTIONS

## COLORS
autoload colors; colors

# The variables are wrapped in %{%}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval RESET='$reset_color'
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE 
export PR_BOLD_WHITE PR_BOLD_BLACK
## END COLORS

# Local untracked settings
[ -f ~/.local.zsh ] && source ~/.local.zsh

fpath=(/usr/local/share/zsh-completions $fpath)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
