function! runt#follow()
    if !exists("s:test_follow_enabled")
        let s:test_follow_enabled = 0
        " Open a vertical split if only one window is open already
        if winnr("$") == 1
            execute "vsplit " . runt#find_test_file_for(expand("%"))
            wincmd h
        endif
        return runt#follow()
    else
        augroup test_follow
            au!
            if !s:test_follow_enabled
                autocmd BufWinEnter * nested call s:do_follow()
                let s:test_follow_enabled = 1
            else
                let s:test_follow_enabled = 0
            endif
        augroup END
    endif
endfun
command! ToggleTestFollow call runt#follow()

function! s:do_follow()
    if winnr() == winnr("$")
        return
    endif

    let path = expand("%")

    call runt#follow()  " temporarily disable so we don't loop
    execute winnr("$") . "wincmd w"
    execute ":edit " . runt#find_test_file_for(expand("%"))
    wincmd p
    call runt#follow()  " re-enable
endfunction

function! runt#is_test_file(path)
    return call(get(b:, 'runt_is_test_file', 'RuntNotImplemented'), [a:path])
endfunction

function! runt#find_test_file_for(path)
    if runt#is_test_file(a:path)
        return a:path
    endif

    let test_file = call(
        \ get(b:, 'runt_find_test_file_for', 'RuntNotImplemented'),
        \ [a:path],
        \ )
    if type(test_file) != type('')
        throw "Couldn't find a test file for '" . a:path . "'"
    else
        return test_file
    endif
endfunction

function! runt#suite(path)
    RuntNotImplemented()
endfunction

function! runt#file(path)
    let t:runt_last_command = call(
        \ get(b:, 'runt_file', 'RuntNotImplemented'),
        \ [runt#find_test_file_for(a:path)],
        \ )
    return t:runt_last_command
endfunction

function! runt#class(path, cursor_pos)
    RuntNotImplemented()
endfunction

function! runt#method(path, cursor_pos)
    RuntNotImplemented()
endfunction

function! RuntNotImplemented(...)
    throw 'Not yet implemented'
endfunction
