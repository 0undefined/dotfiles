function! GetMainDoc()
  let l:maindoc = search('\\begin{document}', "cnw")
  if l:maindoc > 0
    return '%'
  else
    " Find the main document file
    " Must be in the same folder of the current file
    let l:maindocs = split(system("grep -lE '\\\\begin{document}' " . expand('%:h') . "/*.tex"), '\n')
    if len(l:maindocs) > 0
      " Use the first document containing `begin{document}`
      return l:maindocs[0]
    else
      return ""
    endif
  endif
endfunction

function! CompileMainDoc()
  let l:latexcmd ='autocmd BufWritePost <buffer> !
                 \ latexrun --latex-args="-synctex=1 -interaction=nonstopmode" '

  execute(l:latexcmd . GetMainDoc())
endfunction

function! Synctex()
  " remove 'silent' for debugging
  let l:doc = GetMainDoc()
  execute "silent !mv -u latex.out/" . substitute(l:doc, '\.tex', '') . ".synctex.gz ."
  execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . expand('%:t:r') . ".pdf"
  redraw!
endfunction

imap <buffer> FTT \texttt{}<Esc>i
imap <buffer> FBF \textbf{}<Esc>i
imap <buffer> FIT \textit{}<Esc>i
imap <buffer> FSC \textsc{}<Esc>i
imap <buffer> MTT \mathtt{}<Esc>i
imap <buffer> MBF \mathbf{}<Esc>i
imap <buffer> MIT \mathit{}<Esc>i
imap <buffer> MSC \mathsc{}<Esc>i

imap <buffer> MCC \mathcal{}<++><Esc>T{i

inoremap <buffer> <C-j> <Esc>/<++><CR>cf>
noremap  <buffer> <C-j> /<++><CR>cf>

vnoremap <buffer> `it <ESC>`>a}<ESC>`<i\textit{<ESC>
vnoremap <buffer> `bf <ESC>`>a}<ESC>`<i\textbf{<ESC>
vnoremap <buffer> `tt <ESC>`>a}<ESC>`<i\texttt{<ESC>
vnoremap <buffer> `mi <ESC>`>a}<ESC>`<i\mathit{<ESC>
vnoremap <buffer> `mb <ESC>`>a}<ESC>`<i\mathbf{<ESC>
vnoremap <buffer> `mt <ESC>`>a}<ESC>`<i\mathtt{<ESC>

" put \begin{} \end{} tags tags around the current word
vnoremap  <C-B>      YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>kA
nmap <C-M> :call Synctex()<CR>

"setlocal spell spelllang=en_US

call CompileMainDoc()

" autocmd BufRead *.tex imap  /\         \land
" autocmd BufRead *.tex imap  \/         \lor
" autocmd BufRead *.tex imap  ->         \rightarrow
" autocmd BufRead *.tex imap  ~~         \neg
