" A bunch of extra functions stolen from all over the internet
" plus some home made ones
"
" Last Change: 2020-08-14
" Maintainer: pushqrdx <pushqrdx@gmail.com>
" License: MIT

if exists("g:loaded_extra_utils")
    finish
endif

let g:loaded_extra_utils = 1

function! exutils#kill_cmd_line(backwards) abort
  let [text_before_cursor, text_after_cursor] = exutils#split_line_text_at_cursor(v:true)
  call setreg('"', a:backwards ? text_before_cursor : text_after_cursor)
  if a:backwards
    call setcmdpos(1)
  endif
  return a:backwards ? text_after_cursor : text_before_cursor
endfunction

function! exutils#split_line_text_at_cursor(cmdline) abort
  let line = a:cmdline ? getcmdline() : getline('.')
  let pos = a:cmdline ? getcmdpos() : col('.')
  let text_after_cursor = strpart(line, pos - 1, strlen(line))
  let text_before_cursor = strpart(line, 0, pos - 1)
  return [text_before_cursor, text_after_cursor]
endfunction

function! exutils#next_buffer()
  let ind = bufnr()
  let ind += 1
  while ind != bufnr()
    if ind > bufnr('$')
      let ind = 1
    endif
    if s:IsValidBuffer(ind)
      break
    else
      let ind += 1
    endif
  endwhile
  execute "buffer" ind
endfunction

function! exutils#previous_buffer()
  let ind = bufnr()
  let ind -= 1
  while ind != bufnr('')
    if ind < 1
      let ind = bufnr('$')
    endif
    if s:IsValidBuffer(ind)
      break
    else
      let ind -= 1
    endif
  endwhile
  execute "buffer" ind
endfunction

function! s:IsValidBuffer(index)
    return !empty(bufname(a:index)) && empty(getbufvar(a:index, '&buftype'))
endfunction

