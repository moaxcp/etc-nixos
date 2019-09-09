{vim_configurable}:

vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    set number
    set colorcolumn=80

    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  '';
}
