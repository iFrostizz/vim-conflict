" conflict.vim - Open all git conflicting files in buffers
" Last Change:	 2023 Sept 04
" Maintainer:	   Franfran <hello@franfran.dev>
" License:       GPL-3.0

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

function! s:AnyEq(_list, _eq)
  for el in a:_list
    if el == a:_eq
      return 1
    endif
  endfor
  return 0
endfunction

" TODO make this an option
let s:max_lines = 10000 " try to avoid loading too much lines in memory

function! s:Conflicting(_file_loc)
  let conflicting = []
  for _loc in a:_file_loc
    let content_list = readfile(_loc, "", s:max_lines)
    if s:AnyEq(content_list, "<<<<<<< HEAD")
      call add(conflicting, _loc)
    endif
  endfor
  return conflicting
endfunction

function! s:OpenConflicts()
  let files = s:GitDiff()
  let conf_files = s:Conflicting(files)
  if len(conf_files) == 0
    echo "No conflicts found!"
  else
    let as_str = s:ConcatList(conf_files)
    echo "Opening " . as_str
    execute "args " . as_str
  endif
endfunction

if !exists(":Conflicts")
  command Conflicts  :call s:OpenConflicts()
endif
