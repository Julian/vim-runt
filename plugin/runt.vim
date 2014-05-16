function! runt#lock()
    if !exists("s:test_lock_enabled")
        let s:test_lock_enabled = 0
        " Open a vertical split if only one window is open already
        if winnr("$") == 1
            execute "vsplit " . runt#find_file(expand("%"))
            wincmd h
        endif
        return runt#lock()
    else
        augroup test_lock
            au!
            if !s:test_lock_enabled
                autocmd BufWinEnter * nested call s:do_lock()
                let s:test_lock_enabled = 1
            else
                let s:test_lock_enabled = 0
            endif
        augroup END
    endif
endfun
command! ToggleTestLock call runt#lock()

function! s:do_lock()
    if winnr() == winnr("$")
        return
    endif

    let path = expand("%")

    call runt#lock()  " temporarily disable so we don't loop
    execute winnr("$") . "wincmd w"
    execute ":edit " . runt#find_file(expand("%"))
    wincmd p
    call runt#lock()  " re-enable
endfunction

function! runt#is_test_file(path)
    if exists('*b:runt_is_test_file')
        return b:runt_is_test_file(a:path)
    else
        echoerr 'Not yet implemented'
    endif
endfunction

function! runt#find_file(path)
    if runt#is_test_file(a:path)
        return a:path
    elseif exists('*b:runt_find_file')
        return b:runt_find_file(a:path)
    else
        echoerr 'Not yet implemented'
    endif
endfunction

function! runt#suite(path)
    echoerr 'Not yet implemented'
endfunction

function! runt#file(path)
    if exists('*b:runt_file')
        return b:runt_file(runt#find_file(a:path))
    else
        echoerr 'Not yet implemented'
    endif
endfunction

function! runt#class(path, cursor_pos)
    echoerr 'Not yet implemented'
endfunction

function! runt#method(path, cursor_pos)
    echoerr 'Not yet implemented'
endfunction
