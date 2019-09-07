{...}:

{
  programs.bash = {
    enableCompletion = true;
    promptInit = ''
      #change PS1 to use colors and optimize space used. PS1 will show status of previous command.
      set_prompt () {
        local Last_Command="$?"

        local Blue='\[\e[01;34m\]'
        local White='\[\e[01;37m\]'
        local Red='\[\e[01;31m\]'
        local Green='\[\e[01;32m\]'
        local Reset='\[\e[00m\]'
        local FancyX='✘'
        local Checkmark='✔'

        PS1=""

        if [[ "$Last_Command" == 0 ]]; then
            PS1+="$Green$Checkmark"
        else
            PS1+="$Red$FancyX $Red($Last_Command)"
        fi

        PS1+=" $Blue\\\$$Reset "
      }

      export HISTCONTROL=ignoredups:erasedups
      export HISTSIZE=10000
      export HISTFILESIZE=100000
      shopt -s histappend
      export PROMPT_COMMAND="set_prompt; history -a; history -c; history -r; $PROMPT_COMMAND"
    '';
  };
}
