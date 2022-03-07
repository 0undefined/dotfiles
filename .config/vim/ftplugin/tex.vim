imap FTT \texttt{}<Esc>i
imap FBF \textbf{}<Esc>i
imap FIT \textit{}<Esc>i
imap MTT \mathtt{}<Esc>i
imap MBF \mathbf{}<Esc>i
imap MIT \mathit{}<Esc>i

imap MCC \mathcal{}<++><Esc>T{i

inoremap <C-j> <Esc>/<++><CR>cf>
noremap <C-j> /<++><CR>cf>

vnoremap `IT <ESC>`>a}<ESC>`<i\textit{<ESC>
vnoremap `BF <ESC>`>a}<ESC>`<i\textbf{<ESC>
vnoremap `TT <ESC>`>a}<ESC>`<i\texttt{<ESC>
vnoremap `MI <ESC>`>a}<ESC>`<i\mathit{<ESC>
vnoremap `MB <ESC>`>a}<ESC>`<i\mathbf{<ESC>
vnoremap `MT <ESC>`>a}<ESC>`<i\mathtt{<ESC>

" put \begin{} \end{} tags tags around the current word
autocmd BufRead *.tex map  <C-B>      YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>kA
autocmd BufRead *.tex map! <C-B> <ESC>YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>kA
autocmd BufRead *.tex map <C-M> :call Synctex()<CR>

" autocmd BufRead *.tex imap  /\         \land
" autocmd BufRead *.tex imap  \/         \lor
" autocmd BufRead *.tex imap  ->         \rightarrow
" autocmd BufRead *.tex imap  ~~         \neg
