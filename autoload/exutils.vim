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

function! exutils#kill_line() abort
  let [text_before_cursor, text_after_cursor] = exutils#split_line_text_at_cursor()
  if len(text_after_cursor) == 0
    normal! J
  else
    call setreg('"', text_after_cursor)
    call setline(line('.'), text_before_cursor)
  endif
  return ''
endfunction

function! exutils#split_line_text_at_cursor() abort
  let line_text = getline(line('.'))
  let text_after_cursor  = line_text[col('.')-1 :]
  let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
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

