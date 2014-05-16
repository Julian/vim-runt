function! runt#lock()
    if !exists("s:test_lock_enabled")
        let s:test_lock_enabled = 0
        " Open a vertical split if only one window is open already
        if winnr("$") == 1
            execute "vsplit " . runt#find_file()
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
    execute ":edit " . runt#find_file()
    wincmd p
    call runt#lock()  " re-enable
endfunction

function! runt#find_file()
    if exists('*b:runt_find_file')
        return b:runt_find_file()
    else
        echoerr 'Not yet implemented'
    endif
endfunction

function! runt#suite()
    echoerr 'Not yet implemented'
endfunction

function! runt#file()
    echoerr 'Not yet implemented'
endfunction

function! runt#class()
    echoerr 'Not yet implemented'
endfunction

function! runt#method()
    echoerr 'Not yet implemented'
endfunction
