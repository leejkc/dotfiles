set fish_greeting ""
fastfetch
starship init fish | source

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if status is-interactive
    # Commands to run in interactive sessions can go here
end
