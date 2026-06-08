if !exists('g:camelcase_motion')
  let g:camelcase_motion = 0
endif

if !exists('g:camelcase_motion_verbose')
  let g:camelcase_motion_verbose = 0
endif

let s:camelcase_motion_enabled = g:camelcase_motion

function! s:InitCamelCaseMotion()
  silent! unmap w
  silent! unmap b
  silent! unmap e
  silent! unmap ge

  if s:camelcase_motion_enabled
    " Enable camelCase motions
    noremap w [w
    noremap b [b
    noremap e ]w
    noremap ge ]b
    if g:camelcase_motion_verbose
      echo "CamelCase motion ON"
    endif
  else
    " Restore default motions
    noremap w w
    noremap b b
    noremap e e
    noremap ge ge
    if g:camelcase_motion_verbose
      echo "CamelCase motion OFF"
    endif
  endif
endfunction

function! ToggleCamelCaseMotion()
  let s:camelcase_motion_enabled = !s:camelcase_motion_enabled
  call s:InitCamelCaseMotion()
endfunction

call s:InitCamelCaseMotion()
