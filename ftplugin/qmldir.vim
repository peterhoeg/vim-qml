if exists( 'b:did_ftplugin' )
   finish
endif

let b:did_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" command for undo
let b:undo_ftplugin =
   \ 'setlocal ' .
   \    'commentstring< ' .

setlocal commentstring=#\ %s

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
