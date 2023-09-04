" conflict.vim - Open all git conflicting files in buffers
" Last Change:	 2023 Sept 04
" Maintainer:	   Franfran <hello@franfran.dev>
" License:       MIT

if exists("g:loaded_conflict")
  finish
endif
let g:loaded_conflict = 1

function s:GitRoot()
  let root = system('git rev-parse --show-toplevel')
  return root
endfunction

function s:OpenConflicts()
  let root = s:GitRoot()
  echo root
endfunction

if !exists(":Conflicts")
  command Conflicts  :call s:OpenConflicts()
endif
