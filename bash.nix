{...}:

{
  programs.bash = {
    enableCompletion = true;
    promptInit = ''
      set_prompt () {
        if [[ "$?" == 0 ]]; then
          PS1=""
        else
          PS1="\[\e[01;31m\]($?) "
        fi
        PS1+="\[\e[01;;34m\]\\\$\[\e[00m\] " 
      }

      export HISTCONTROL=ignoredups:erasedups
      export HISTSIZE=10000
      export HISTFILESIZE=100000
      shopt -s histappend
      export PROMPT_COMMAND="set_prompt; history -a; history -c; history -r;"
    '';
  };
}
