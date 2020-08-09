" put \begin{} \end{} tags tags around the current word
autocmd BufRead *.tex map  <C-B>      YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>kA
autocmd BufRead *.tex map! <C-B> <ESC>YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>kA
autocmd BufRead *.tex map <C-M> :call Synctex()<CR>

"autocmd BufRead *.tex imap  /\         \land
"autocmd BufRead *.tex imap  \/         \lor
"autocmd BufRead *.tex imap  ->         \rightarrow
"autocmd BufRead *.tex imap  ~~         \neg
