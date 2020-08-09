" Vim compiler file
" Compiler:           Futhark Compiler
" Latest Revision:    2020/05/24

if exists("current_compiler") || &cp
  finish
endif
let current_compiler = "futhark"

let s:cpo_save = "futhark"
set cpo&vim

"CompilerSet errorformat=Error at %f:%l:%c-%v:\r%m


let &cpo = s:cpo_save
unlet s:cpo_save
