scriptencoding utf-8

" Wrapped line navigation
" https://stackoverflow.com/questions/20975928/moving-the-cursor-through-long-soft-wrapped-lines-in-vim
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'



" Navigate HTML/XML tags
" https://stackoverflow.com/questions/6270396/navigating-html-tags-in-vimdiff
" You can jump between tags using visual operators, in example:
"
" Place the cursor on the tag.
" Enter visual mode by pressing v.
" Select the outer tag block by pressing a+t or i+t for inner tag block.
" Your cursor should jump forward to the matching closing html/xml tag. To
" jump backwards from closing tag, press o or O to jump to opposite tag.
"
" Now you can either exit visual by pressing Esc, change it by c or copy by y.
"
" To record that action into register, press qq to start recording, perform
" tag jump as above (including Esc), press q to finish. Then to invoke jump,
" press @q (to repeat, hit @@).
"
" See more help at :help visual-operators or :help v_it:
"
" at a <tag> </tag> block (with tags)
"
" it inner <tag> </tag> block
"
" Alternatively use plugin such as matchit.vim (See: Using % in languages
" without curly braces).





" vimdiff set wrap all buffers (window)
" `windo set wrap`
" This moves cursor to last buffer

" Vim 8 has native plugin support, should I still use vim-plug?

" Before loading plugins disable LSP for ALE so that only CoC will do LSP
let g:ale_disable_lsp = 1

" Plug pluggins {{{
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" When adding new plugins use `PlugInstall` to install them
" To update plugins (download latest versions, git pull) run `PlugUpdate`
" To uninstall a plugin, remove the line and run `PlugClean`

" Make sure you use single quotes

" colorschemes
Plug 'crusoexia/vim-monokai'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'
"Plug 'sainnhe/forest-night' Renamed to everforest
Plug 'sainnhe/everforest'
Plug 'sainnhe/gruvbox-material'
Plug 'NLKNguyen/papercolor-theme'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

" filetype
"Plug 'google/vim-jsonnet'
Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'Glench/Vim-Jinja2-Syntax'
"Plug 'mustache/vim-mustache-handlebars'
Plug 'carlsmedstad/vim-bicep'

"Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

Plug 'hashivim/vim-terraform'
"Plug 'juliosueiras/vim-terraform-completion'

" GraphQL Syntax Highlighting
Plug 'jparise/vim-graphql'

"Plug 'MicahElliott/Rocannon'
"Plug 'hejack0207/ansible.vim'	" fork of Rocannon, more up-to-date
Plug 'djpohly/vim-execline'
Plug 'NoahTheDuke/vim-just'

" ALE is better than syntastic as it is asynchronous
"Plug 'vim-syntastic/syntastic'
"Plug 'dense-analysis/ale'

" COC
"
" If experiencing bad behaviour try `CocUpdate` to update coc plugins
"
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/mycomment.vim'

" completion plugins
"Plug 'lifepillar/vim-mucomplete'

" LSP
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'

" async complete
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'

"Plug 'majutsushi/tagbar'

Plug 'Yggdroot/indentLine'

Plug 'dhruvasagar/vim-table-mode'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'jeetsukumaran/vim-indentwise'
Plug 'powerman/vim-plugin-AnsiEsc'

" limelight turns off syntax highlight and dims other paragraphs, to highlight
" current paragraph. Could be good for presentations so people focus on the
" bit you want to show them. But, otherwise, I prefer seeing the syntax
" highlighting everywhere. Dimming is cool though.
" `:Limelight`, `Limelight0.8`, `Limelight0.1`  float changes dimming level
" `:Limelight!` turns it off
"Plug 'junegunn/limelight.vim'

" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
"Plug 'dyng/ctrlsf.vim'

"Plug 'reedes/vim-lexical'

" 🌵 Viewer & Finder for LSP symbols and tags
Plug 'liuchengxu/vista.vim'


" Initialize plugin system
call plug#end()
" }}}

" vimscript folding {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Tip: use `:set signcolumn=no" to turn off diagnostics for copy-pasting

" use `:IndentLinesToggle` to toggle to hide for copy-pasting
" This plugin is also concealing `"` double-quotes in json files, which looks
" pretty but make editing difficult., use the toggle command to flick off/on
" sublime style
let g:indentLine_char = '┊'

" Run `:sign unplace group=* *` to hide all sign gutters (for copying and

""" ALE setup {{{
" Run `:sign unplace group=ale *` to hide the sign gutter (for copying and pasting)
" pasting)
" Run `:ALEInfo` to see value of variables and output of commands etc.
"   suggested linters etc. It will show you if the necessary external comamnds
"   are installed or not, if the command failed.
" Needs `flake8` installed, `apk add py3-flake8` or `pip install flake8`
" bandit - python security linter
" mypy - python type-checking
"let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'bandit', 'mypy'], 'java': []}
let g:ale_linters = {'python': [], 'java': []}
" https://github.com/dense-analysis/ale/issues/3379
" alex mainly finds things like XXX, fire, just, failure, etc. which are fine in the contexts I'm using them.
let g:ale_linters_ignore = {
  \   'markdown': ['languagetool'],
  \   'asciidoc': ['languagetool', 'alex', 'write-good']
  \}
" black - uncompromising opinionated fixer, not configurable, deterministic
" isort - isort your imports, so you don't have to
"let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
" remove_trailing_lines, and  trime_whitespace are builtin fixers
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black', 'isort']}
" If you want to make a minimal patch and don't want the ALE fixer touching
" many lines you can do `let b:ale_fixers = {'*': []}`, this will set it just
" for the buffer rather than globally.
" You can view the values of internal-variables with `echo g:ale_fixers` etc.
" For vim script language linting
" - Install node, follow
"   https://github.com/nodejs/docker-node/blob/master/12/alpine3.12/Dockerfile
"   - Install yarn too
" - Install https://github.com/iamcco/vim-language-server
"   - This is a LSP for Vimscript
"   - `sudo -H yarn global add vim-language-server`
"     - Without sudo the `vim-language-server` command won't be installed,
"     and no error from `yarn`.
" - `sudo -H python3 -m pip install vim-vint
" Fix on saving
let g:ale_fix_on_save = 1
" }}}

" Fix mouse resizing of windows in tmux
set ttymouse=sgr

" Fix terminal background color erase (BCE) copying problem
" In `tmux` TERM is tmux-256color and it doesn't support BCE, so vim uses
" spaces. Copying pasting with the mouse will copy lots of spaces.
" vim's `t_ut` variable controls the use of BCE.
"set t_ut=y

" Use a line cursor within insert mode and a block cursor everywhere else.
" https://github.com/nickjj/dotfiles/blob/master/.vimrc
"
" Using iTerm2? Go-to preferences / profile / colors and disable the smart bar
" cursor color. Then pick a cursor and highlight color that matches your theme.
" That will ensure your cursor is always visible within insert mode.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


""" CoC Setup {{{
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-python',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ ]
  "\ 'coc-pairs',

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has('patch-8.1.1564')
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" asyncomplete
" tab completion
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

""" https://github.com/prabirshrestha/asyncomplete.vim/pull/6
"let g:asyncomplete_auto_popup = 0

" Vista keybinding to allow search with fzf in vista window
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> / :<c-u>call vista#finder#fzf#Run()<CR>

"
" XXX This stops you from inserting tabs after a  `:` in a Makefile...

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"
" Updated to Coc 0.0.82, got popup:
"   coc.vim switched to custom popup menu from 0.0.82
"   you have to change key-mapping of <tab> to make it work.
"   checkout current key-mapping by ":verbose imap <tab>"
"   checkout documentation by ":h coc-completion"
" Commenting this out for now
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      "\ asyncomplete#force_refresh()
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" New attempt:
"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"""

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"
" Updated to Coc 0.0.82, got popup:
"   coc.vim switched to custom popup menu from 0.0.82
"   you have to change key-mapping of <tab> to make it work.
"   checkout current key-mapping by ":verbose imap <tab>"
"   checkout documentation by ":h coc-completion"
" Commenting this out for now
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"   Use `C-o` to go back to where you were
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"
" This seems old now:
"nnoremap <silent> <leader> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . ' ' . expand('<cword>')
"  endif
"endfunction
"
" New way from FAQ:
" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#how-to-show-documentation-of-symbol-under-cursor-also-known-as-cursor-hover
"
"nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>
"nnoremap <silent> <leader>K :call CocActionAsync('doHover')<cr>
"nnoremap <silent> <leader> K :call CocActionAsync('doHover')<cr>
" Only this one seems to work properly
nnoremap <silent> K :call CocActionAsync('doHover')<cr>

" Highlight the symbol and its references when holding the cursor.
augroup coc-highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
"nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
"inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}


" airline stuff {{{
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='powerlineish'
let g:airline_theme='monokai_tasty'                   " airline theme
" }}}



" statusline stuff {{{
" vim-terraform-completion
" Syntastic Config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
" }}}

" syntastic stuff {{{
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" }}}

" completion stuff {{{
" (Optional)Remove Info(Preview) window
"set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
augroup berney-completion
  autocmd!
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END
" }}}

" terraform plugin tweaks {{{
" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0
" }}}


" highlight trailing whitespace {{{
"highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
"highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
" Use autocmd so color schemes don't clear it
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
augroup berney-whitespace
  autocmd!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
augroup END
" }}}


" colorschemes {{{

" sainnhe/sonokai
" From `help sonokai`, same for other sainnhe colorschemes like edge etc
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
"let g:sonokai_style = 'default'
"let g:sonokai_style = 'andromeda'
"let g:sonokai_style = 'atlantis'
"let g:sonokai_style = 'shusia'
"let g:sonokai_style = 'maia'
"let g:sonokai_style = 'espresso'
let g:sonokai_better_performance = 1
"let g:edge_style = 'default'
"let g:edge_style = 'aura'
"let g:edge_style = 'neon'
let g:edge_better_performance = 1
"let g:edge_transparent_background= 0
set background=dark
"
" XXX highlighted spelling mistakes in `set spell` don't display in these
" sainnhe color schemes
"
"colorscheme sonokai
" need `set background=dark` to get dark background, defaults to light
"colorscheme edge
"colorscheme everforest
"colorscheme gruvbox-material

" colorscheme elflord
" doesn't have nice colors for Pmenu
colorscheme monokai
"let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
"colorscheme vim-monokai-tasty
"colorscheme gruvbox
" }}}

" coc highlight colorscheme fix {{{
" Coc with monokai has really ugly dark red on grey for error popups which
" looks shit with monokai
"
" Original
" CocErrorFloat  xxx ctermfg=52 ctermbg=237 guifg=#ff0000 guibg=#3f4145
highlight CocErrorFloat ctermfg=Red guifg=#ff0000
" }}}


" tweaking colors {{{
" If you don't like a particular colour choice from `vim-monokai-tasty`, you can
" override it here. For example, to change the colour of the search hightlight:
"hi Search guifg=#bada55 guibg=#000000 gui=bold ctermfg=green ctermbg=black cterm=bold
"hi Pmenu guifg=#bada55 guibg=#000000 gui=bold ctermfg=green ctermbg=black cterm=bold

" If you don't know what the name of a particular hightlight is, you can use
" `What`. It will print out the syntax group that the cursor is currently above.
" from https://www.reddit.com/r/vim/comments/6z4aau/how_to_stop_vim_from_autohighlighting_italics_in/
command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')
" }}}

" Coc undercurl - not working {{{
hi CocUnderline gui=undercurl term=undercurl
hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=undercurl term=undercurl
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl
" }}}

" basic {{{
set cursorline
set hlsearch
" start highlighting whilst type search pattern
set incsearch
set linebreak
" }}}

" vim-lexical {{{
"augroup lexical
"  autocmd!
"  autocmd FileType markdown,mkd call lexical#init()
"  autocmd FileType textile call lexical#init()
"  autocmd FileType text call lexical#init({ 'spell': 0 })
"  autocmd FileType asciidoc call lexical#init()
"augroup END
" }}}


""" leader stuff {{{
" - leader is like a namespace for custom mappings to stop them from clashing
"   with default keybindings.
" - https://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
" - https://learnvimscriptthehardway.stevelosh.com/chapters/06.html
"
" change leader key from default (`\`) to `,` (which is normal bound to
" something else, but maybe not interesting)
let mapleader = ','

" will show the leader (defaults to `\`), it will disappear after the timeout
set showcmd

" Mouse Scroll Wheel to change buffers
nnoremap <C-ScrollWheelDown> :bn<CR>
nnoremap <C-ScrollWheelUp> :bp<CR>
" Mouse Scroll Wheel to change quickfix
" - example: Pipe ripgrep into vim and scroll between findings: `rg --sort path '^tags: .*macOS' --vimgrep | vim -q /dev/stdin`
nnoremap <A-ScrollWheelDown> :cnext<CR>
nnoremap <A-ScrollWheelUp> :cprev<CR>


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" `,W` to mean "strip all trailing whitespace in the current file" so I can clean things up quickly
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Edit my Vimrc
"   - quickly open up my ~/.vimrc file in a vertically split window so I can add new things to it on the fly
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Source my Vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" normal mode map leader j/k to ALENext/Previous to jump to errors/warnings
nnoremap <silent> <leader>j :ALENextWrap<cr>
nnoremap <silent> <leader>k :ALEPreviousWrap<cr>

" vim-lexical
"let g:lexical#thesaurus_key = '<leader>t'

" toggle Vista sidebar
nnoremap <leader>v :Vista!!<cr>

" toggle coc-explorer
nnoremap <leader>e :CocCommand explorer<cr>
nnoremap <leader>ee :CocCommand explorer<cr>

" coc-explorer Reveal to current buffer for closest coc-explorer
nnoremap <Leader>er :call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>
" }}}

"echom '>^.^<'

" tail -f in vim https://stackoverflow.com/a/48296697 {{{
" :set autoread | au CursorHold * checktime | call feedkeys("lh")
" }}}


set mouse=a

" // at the end ensures filenames are unique
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backups//
set modeline
