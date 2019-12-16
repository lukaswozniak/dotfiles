" jump to header
map <buffer> <leader>hh :execute ':find ' . expand("%:t:r") . '.hpp'<cr>
" jump to impl
map <buffer> <leader>hi :execute ':find ' . expand("%:t:r") . '.cpp'<cr>
