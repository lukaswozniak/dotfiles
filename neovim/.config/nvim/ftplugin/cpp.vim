" jump to header
map <buffer> <leader>hh :execute ':find ' . expand("%:t:r") . '.hpp'<cr>
" jump to impl
map <buffer> <leader>hi :execute ':find ' . expand("%:t:r") . '.cpp'<cr>

" paste to include header macro
let @h = 'mm?#includeo#include "0"''m'
