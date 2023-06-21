if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let g:markdown_fenced_languages = ['c', 'css', 'sh', 'vim', 'futhark']
let g:markdown_minlines = 64

setlocal spell
setlocal spelllang=en_us
