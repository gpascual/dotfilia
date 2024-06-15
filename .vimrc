syntax enable
set background=dark
colorscheme dracula
set number relativenumber

set shiftwidth=4 smarttab expandtab

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

