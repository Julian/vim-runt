function! runt#follow()
    if !exists("s:test_follow_enabled")
        let s:test_follow_enabled = 0
        " Open a vertical split if only one window is open already
        if winnr("$") == 1
            execute "vsplit " . runt#find_file(expand("%"))
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
    execute ":edit " . runt#find_file(expand("%"))
    wincmd p
    call runt#follow()  " re-enable
endfunction

function! runt#is_test_file(path)
    if exists('b:runt_is_test_file')
        return call(b:runt_is_test_file, [a:path])
    else
        throw 'Not yet implemented'
    endif
endfunction

function! runt#find_file(path)
    if runt#is_test_file(a:path)
        return a:path
    elseif exists('b:runt_find_file')
        return call(b:runt_find_file, [a:path])
    else
        throw 'Not yet implemented'
    endif
endfunction

function! runt#suite(path)
    throw 'Not yet implemented'
endfunction

function! runt#file(path)
    if exists('b:runt_file')
        let t:runt_last_command = call(b:runt_file, [runt#find_file(a:path)])
        return t:runt_last_command
    else
        throw 'Not yet implemented'
    endif
endfunction

function! runt#class(path, cursor_pos)
    throw 'Not yet implemented'
endfunction

function! runt#method(path, cursor_pos)
    throw 'Not yet implemented'
endfunction
