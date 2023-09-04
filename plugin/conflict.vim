" conflict.vim - Open all git conflicting files in buffers
" Last Change:	 2023 Sept 04
" Maintainer:	   Franfran <hello@franfran.dev>
" License:       MIT

if exists("g:loaded_conflict")
  finish
endif
let g:loaded_conflict = 1

function! s:GitRoot()
  let root = system('git rev-parse --show-toplevel')
  return root
endfunction

function! s:AsUnique(_list)
  let unique_list = []
  for el in a:_list
    if index(unique_list, el) == -1
      call add(unique_list, el)
    endif
  endfor
  return unique_list
endfunction

function! s:ConcatList(_list)
  let ret_str = ""
  for el in a:_list
    let el_space = el . " "
    let ret_str = el_space . ret_str
  endfor
  return ret_str
endfunction

function! s:GitDiff()
  let diff_ret = system('git diff --name-only')
  let diff_files = split(diff_ret, "\n")
  return s:AsUnique(diff_files)
endfunction

function! s:OpenConflicts()
  let root = s:GitRoot()
  let files = s:GitDiff()
  let as_str = s:ConcatList(files)
  echo as_str
  execute "args " . as_str
endfunction

if !exists(":Conflicts")
  command Conflicts  :call s:OpenConflicts()
endif
