function! GetMainDoc()
  let l:maindoc = search('\\begin{document}', "cnw")
  if l:maindoc > 0
    return '%'
  else
    " Find the main document file
    " Must be in the same folder of the current file
    let l:maindocscmd = "grep -lrE '\\\\begin{document}' " . expand('%:h') . "/*.tex"
    let l:maindocssys = system(l:maindocscmd)
    let l:maindocs = split(l:maindocssys)
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
  execute "silent !mv -u latex.out/" . substitute(l:doc, '\.tex', '') . ".synctex.gz ."
  execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
  redraw!
endfunction
nmap <C-M> :call Synctex()<CR>

setlocal spell
setlocal spelllang=en_us

imap <buffer> FTT \texttt{}<Esc>i
imap <buffer> FBF \textbf{}<Esc>i
imap <buffer> FIT \textit{}<Esc>i
imap <buffer> FSC \textsc{}<Esc>i
imap <buffer> MTT \mathtt{}<Esc>i
imap <buffer> MBF \mathbf{}<Esc>i
imap <buffer> MIT \mathit{}<Esc>i
imap <buffer> MSC \mathsc{}<Esc>i

imap <buffer> (( \left(\right)<Esc>F\i
imap <buffer> {{ \left\{\right\}<Esc>F\F\i
imap <buffer> [[ \left[\right]<Esc>F\i

imap <buffer> ~~ \neg
imap <buffer> /\ \land
imap <buffer> \/ \lor
imap <buffer> -> \rightarrow
imap <buffer> ==> \Rightarrow
imap <buffer> <== \Leftarrow
imap <buffer> <=> \Leftrightarrow
imap <buffer> \|- \vdash
imap <buffer> \|= \vDash
imap <buffer> !-- \inference[]{%<CR>}{%<CR>}<ESC>kk$F[a
imap <buffer> !== \begin{align*}<CR>\end{align*}<ESC>O
imap <buffer> !ii \begin{itemize}<CR>\end{itemize}<ESC>O\item Case<ESC>
imap <buffer> CC \item Case
imap <buffer> EIMP \expEimp{<++>}{<++>}{<++>}<ESC>F\<C-j>
imap <buffer> [[ [\![
imap <buffer> ]] ]\!]

imap <buffer> <leader>CI $\land\mbox{I}$
imap <buffer> <leader>CE1 $\land\mbox{E}_1$
imap <buffer> <leader>CE2 $\land\mbox{E}_2$
imap <buffer> <leader>DI1 $\lor\mbox{I}_1$
imap <buffer> <leader>DI2 $\lor\mbox{I}_2$
imap <buffer> <leader>DE  $\lor\mbox{E}$
imap <buffer> <leader>II $\Rightarrow\mbox{I}$
imap <buffer> <leader>IE $\Rightarrow\mbox{E}$
imap <buffer> <leader>NE $\neg\mbox{E}$
imap <buffer> <leader>NI $\neg\mbox{I}$

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

syntax sync minlines=10000

call CompileMainDoc()
