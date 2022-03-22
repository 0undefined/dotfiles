" ftplugin/fut.vim
setlocal commentstring=--%s
setlocal comments=:--
setlocal iskeyword+=',_
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

setlocal makeprg=futhark\ check\ %

setlocal errorformat=%E[91mError\ at\ %f:%l:%c-%k:[0m
"setlocal errorformat+=%W[91mWarning\ at\ %f:%l:%c-%k:[0m%m
setlocal errorformat+=%-CExpected%.%#
setlocal errorformat+=%-CActual%.%#
setlocal errorformat+=%-C\ %.%#
setlocal errorformat+=%C%m%.%#
setlocal errorformat+=%-G\ %#https://github.com/diku-dk/futhark/issues
setlocal errorformat+=%-GIf\ you%.%#
setlocal errorformat+=%-G%.%#

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
