{...}:

{
  programs.bash = {
    enableCompletion = true;
    promptInit = ''
      #change PS1 to use colors and optimize space used. PS1 will show status of previous command.
      set_prompt () {
        Last_Command=$? # Must come first!
        Blue='\[\e[01;34m\]'
        White='\[\e[01;37m\]'
        Red='\[\e[01;31m\]'
        Green='\[\e[01;32m\]'
        Reset='\[\e[00m\]'
        FancyX='-'
        Checkmark='+'

        # Add a bright white exit status for the last command
        PS1="$White\$? "
        # If it was successful, print a green check mark. Otherwise, print
        # a red X.
        if [[ $Last_Command == 0 ]]; then
            PS1+="$Green$Checkmark "
        else
            PS1+="$Red$FancyX "
        fi
        # If root, just print the host in red. Otherwise, print the current user
        # and host in green.
        if [[ $EUID == 0 ]]; then
            PS1+="$Red\\h "
        else
            PS1+="$Green\\u@\\h "
        fi
        # Print the working directory and prompt marker in blue, and reset
        # the text color to the default.
        PS1+="$Blue\\W \\\$$Reset "
      }
      export HISTCONTROL=ignoredups:erasedups
      export HISTSIZE=10000
      export HISTFILESIZE=100000
      shopt -s histappend
      export PROMPT_COMMAND="history -a; history -c; history -r; set_prompt; $PROMPT_COMMAND"
    '';
  };
}
