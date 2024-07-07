"vimrc file

" Set Search highlighting and toggle on F3
set hlsearch
noremap <F3> :set hlsearch!<CR>

" plug-vim
call plug#begin('~/.vim/plugged')

syntax enable
Plug 'rust-lang/rust.vim'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

call plug#end()

" Delete trailing white spaces and save cursor
function! NoTrailingWS()
  :%s/\s\+$//e
endfunction

function! SetupEnvironment()
  " always cleanup trailing WS
  autocmd BufWritePre <buffer> :call NoTrailingWS()

  " restore the cursor
  normal! g`"

  "" Project specific Vim settings
  " QEMU - always 4 tabs, expand tabs, delete white spaces
  let l:path = expand('%:p')
  if l:path =~ '/home/gabhijit/Test/qemu/'
    setlocal shiftwidth=4 expandtab softtabstop=4 smarttab textwidth=0
  endif

  " All facebook libraries follow this coding style.
  let l:path = expand('%:p')
  if l:path =~ '/home/gabhijit/Test/folly/'
    setlocal shiftwidth=2 expandtab softtabstop=2 smarttab textwidth=0
  endif

endfunction

" run rustfmt on saving a rust file
let g:rustfmt_autosave = 1

filetype indent plugin on
autocmd BufReadPost,BufNewFile * call SetupEnvironment()
