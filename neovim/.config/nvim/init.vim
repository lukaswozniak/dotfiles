" .vimrc / init.vim
" ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')
" General {{{
    set autoread " detect when a file is changed
    set history=1000 " change history to 1000
    set colorcolumn=130
    set shell=$SHELL

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    if has('persistent_undo')
        let myUndoDir = expand('$HOME/.vim-undo')
        :silent call system('mkdir -p ' . myUndoDir)
        let &undodir = myUndoDir
        set undofile
    endif

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard=unnamedplus
    set guioptions=aA

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros
    set magic " Set magic on, for regex
    set path=**

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500

    " quickfix options
    set switchbuf+=usetab,newtab " openfiles in new tab, and reuse if file already opened

    " splitting to right and below by default
    set splitbelow
    set splitright

    " substitutions
    set gdefault " global substitute by default

    " automatic resize of splits
    autocmd VimResized * wincmd =
" }}}

" Appearance {{{
    set number " show line numbers
    set nowrap " turn off line wrapping
    set showbreak=… " show ellipsis at breaking
    set diffopt+=vertical
    set laststatus=2 " show the satus line all the time
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink

    " Tab control
    set expandtab " insert spaces rather than tab for <Tab>
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 " edit as if the tabs are 4 characters wide
    set shiftwidth=4 " number of spaces to use for indent and unindent
    set shiftround " round indent to a multiple of 'shiftwidth'
    set autoindent " automatically set indent of new line
    set cindent " automatically set indent of new line

    " code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1

    set t_Co=256
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " enable 24 bit color support if supported
    if has("termguicolors")
        if (!(has("nvim")))
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " Load colorschemes
    Plug 'morhetz/gruvbox'

    " LightLine {{{
            Plug 'itchyny/lightline.vim'
            Plug 'shinchu/lightline-gruvbox.vim'
            let g:lightline = {
            \   'coloscheme': 'gruvbox',
            \   'active': {
            \       'left': [ [ 'mode', 'paste' ],
            \               [ 'gitbranch' ],
            \               [ 'readonly', 'filetype', 'filename' ]],
            \       'right': [ [ 'percent' ], [ 'lineinfo' ],
            \               [ 'fileformat', 'fileencoding' ],
            \               [ 'linter_errors', 'linter_warnings' ]]
            \   },
            \   'component_expand': {
            \       'linter': 'LightlineLinter',
            \       'linter_warnings': 'LightlineLinterWarnings',
            \       'linter_errors': 'LightlineLinterErrors',
            \       'linter_ok': 'LightlineLinterOk'
            \   },
            \   'component_type': {
            \       'readonly': 'error',
            \       'linter_warnings': 'warning',
            \       'linter_errors': 'error'
            \   },
            \   'component_function': {
            \       'fileencoding': 'LightlineFileEncoding',
            \       'gitbranch': 'LightlineGitBranch'
            \   },
            \   'tabline': {
            \       'left': [ [ 'tabs' ] ],
            \       'right': [ [ 'close' ] ]
            \   },
            \   'tab': {
            \       'active': [ 'filename', 'modified' ],
            \       'inactive': [ 'filename', 'modified' ],
            \   },
            \   'separator': { 'left': '', 'right': '' },
            \   'subseparator': { 'left': '', 'right': '' }
            \ }

            function! LightlineFileName() abort
                let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
                if filename =~ 'NERD_tree'
                    return ''
                endif
                let modified = &modified ? ' +' : ''
                return fnamemodify(filename, ":~:.") . modified
            endfunction

            function! LightlineFileEncoding()
                " only show the file encoding if it's not 'utf-8'
                return &fileencoding == 'utf-8' ? '' : &fileencoding
            endfunction

            function! LightlineLinter() abort
                let l:counts = ale#statusline#Count(bufnr(''))
                return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
            endfunction

            function! LightlineLinterWarnings() abort
                let l:counts = ale#statusline#Count(bufnr(''))
                let l:all_errors = l:counts.error + l:counts.style_error
                let l:all_non_errors = l:counts.total - l:all_errors
                return l:counts.total == 0 ? '' : '! ' . printf('%d', all_non_errors)
            endfunction

            function! LightlineLinterErrors() abort
                let l:counts = ale#statusline#Count(bufnr(''))
                let l:all_errors = l:counts.error + l:counts.style_error
                return l:counts.total == 0 ? '' : 'X ' . printf('%d', all_errors)
            endfunction

            function! LightlineLinterOk() abort
                let l:counts = ale#statusline#Count(bufnr(''))
                return l:counts.total == 0 ? 'OK' : ''
            endfunction

            function! LightlineGitBranch()
                return "git: " . (exists('*fugitive#head') ? fugitive#head() : 'no')
            endfunction

            augroup alestatus
                autocmd User ALELintPost call lightline#update()
            augroup end
        " }}}

" General Mappings {{{
    " set a map leader for more key combos
    let mapleader = ','

    " shortcut to save
    nmap <leader>, :w<cr>

    " set paste toggle
    set pastetoggle=<leader>v

    " fast edits
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>
    map <leader>eg :e! ~/.gitconfig<cr>

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " map Q to @q in visual selections
    xnoremap Q :'<,'>:normal @q<CR>

" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
" }}}

" General Functionality {{{
    " search inside files using ripgrep. This plugin provides an Ack command.
    Plug 'wincent/ferret'

    let g:FerretExecutableArguments = {
    \ 'ag': '--column --ignore tags'
    \ }

    " insert or delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'

    " easy commenting motions - shortcut gcc
    Plug 'tpope/vim-commentary'

    " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-unimpaired'

    " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-ragtag'

    " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-surround'

    " tmux integration for vim
    Plug 'benmills/vimux'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " add end, endif, etc. automatically
    Plug 'tpope/vim-endwise'

    " context-aware pasting
    Plug 'sickill/vim-pasta'

    " some UNIX shell commands like :Chmod :SudoWrite
    Plug 'tpope/vim-eunuch'

    " AyncRun command to run scripts async
    Plug 'skywind3000/asyncrun.vim'

    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
        Plug 'Xuyuanp/nerdtree-git-plugin'
        let NERDTreeDirArrowExpandable = " " "make arrows invisible
        let NERDTreeDirArrowCollapsible = " " " make arrows invisible

        augroup nerdtree
            autocmd!
            autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
            autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
        augroup END

        " Toggle NERDTree
        function! ToggleNerdTree()
            if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
        endfunction
        " toggle nerd tree
        nmap <silent> <leader>k :call ToggleNerdTree()<cr>
        " find the current file in nerdtree without needing to reload the drawer
        nmap <silent> <leader>y :NERDTreeFind<cr>

        let NERDTreeShowHidden=1
    " }}}

    " FZF {{{
        Plug '/usr/local/opt/fzf'
        Plug '~/.fzf'
        Plug 'junegunn/fzf.vim'
        let g:fzf_layout = { 'down': '~25%' }

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<cr>
        endif

        nmap <silent> <leader>s :GFiles?<cr>

        nmap <silent> <leader>r :Buffers<cr>
        nmap <silent> <leader>e :FZF<cr>
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    " }}}

    " signify {{{
        Plug 'mhinz/vim-signify'
        let g:signify_vcs_list = [ 'git' ]
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        Plug 'junegunn/gv.vim' " git commit browser
    " }}}
" }}}

" ALE {{{
    Plug 'w0rp/ale' " Asynchonous linting engine
    let g:ale_set_highlights = 1
    let g:ale_change_sign_column_color = 0
    let g:ale_sign_column_always = 1
    " let g:ale_lint_delay = 1000
    let g:ale_lint_on_text_changed = 'always'
    let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
    " let g:ale_completion_enabled = 1

    let g:ale_linters = {}
    let g:ale_fixers = {
        \ '*': ['trim_whitespace'],
    \}
    let g:ale_fix_on_save = 1
    let g:ale_maximum_file_size = 32768
    nmap <silent><leader>af :ALEFix<cr>
    nmap <silent><leader>an :ALENext<cr>
    nmap <silent><leader>ap :ALEPrevious<cr>
" }}}

" Styles {{{
    Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
" }}}

" Markbar {{{
    Plug 'Yilin-Yang/vim-markbar'
    nmap <leader>m <Plug>ToggleMarkbar
" }}}

" AdvancedSorters {{{
    Plug 'vim-scripts/ingo-library'
    Plug 'vim-scripts/AdvancedSorters'
" }}}

" Language-Specific Configuration {{{
    Plug 'ekalinin/Dockerfile.vim'
    Plug 'gustafj/vim-ttcn'
    Plug 'https://bitbucket.org/akrzyz/vim-cp-syntax.git'
    Plug 'mfukar/robotframework-vim'
" }}}


call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    let g:gruvbox_contrast_dark='hard'
    set background=dark
    silent! colorscheme gruvbox
    syntax on
    filetype plugin indent on
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333
    highlight ColorColumn ctermbg=green guibg=green
    " allow terminal opacity
    highlight Normal guibg=NONE ctermbg=NONE
" }}}


com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
