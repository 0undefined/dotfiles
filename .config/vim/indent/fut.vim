" Vim indent file
" Language:         Futhark
" Authors:          Bene Collyridam, 0undefined
" Last Change:      2020/01/11

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nolisp
setlocal autoindent

setlocal indentkeys=0{,0},0),0],!^F,e,o,O
setlocal indentexpr=FutharkIndent(v:lnum)

if exists("*FutharkIndent")
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

function! s:get_line_trimmed(lnum)
	" Get the line and remove a trailing comment.
	" Use syntax highlighting attributes when possible.
	" NOTE: this is not accurate; /* */ or a line continuation could trick it
	let line = getline(a:lnum)
	let line_len = strlen(line)
	if has('syntax_items')
		" If the last character in the line is a comment, do a binary search for
		" the start of the comment.  synID() is slow, a linear search would take
		" too long on a long line.
		if synIDattr(synID(a:lnum, line_len, 1), "name") =~ 'Comment\|Todo'
			let min = 1
			let max = line_len
			while min < max
				let col = (min + max) / 2
				if synIDattr(synID(a:lnum, col, 1), "name") =~ 'Comment\|Todo'
					let max = col
				else
					let min = col + 1
				endif
			endwhile
			let line = strpart(line, 0, min - 1)
		endif
		return substitute(line, "\s*$", "", "")
	else
		" Sorry, this is not complete, nor fully correct (e.g. string "--").
		" Such is life.
		return substitute(line, "\s*--.*$", "", "")
	endif
endfunction

function! FutharkIndent(lnum)
  let line = getline(a:lnum)
  let prevNum = prevnonblank(a:lnum - 1)
  let prev = s:get_line_trimmed(prevNum)
  while prevNum > 1 && prevline !~ '[^[:blank:]]'
    let prevNum = prevnonblank(prevNum - 1)
    let prev = s:get_line_trimmed(prevNum)
  endwhile

  if prev[len(prevline) - 1] == ","
        \ && s:get_line_trimmed(a:lnum) !~ '^\s*[\[\]{}]'
        \ && prevline !~ '^\s*let\s'
        \ && prevline !~ '([^()]\+,$'
        \ && s:get_line_trimmed(a:lnum) !~ '^\s*\S\+\s*=>'
    return indent(prevNum)
  endif

  " Indent extra if matching these patterns
  if prev =~ "=$"
      \ || prev =~ "->$"
      \ || prev =~ "do$"
      \ || prev =~ "($"
      \ || prev =~ "in$"
      \ || prev =~ "then$"
      \ || prev =~ "else$"
    return indent(prevNum) + &shiftwidth

  " Else keep same level of indentation
  else
    return indent(prevNum)

  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
