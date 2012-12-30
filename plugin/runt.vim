function! ToggleTestLock()
    if !exists("s:test_lock_enabled")
        let s:test_lock_enabled = 0
        " Open a vertical split if only one window is open already
        if winnr("$") == 1
            exec "vsp " . FindTestFile(expand("%"))
            wincmd h
        endif
        return ToggleTestLock()
    else
        augroup test_lock
            au!
            if !s:test_lock_enabled
                autocmd BufWinEnter * nested call <SID>DoTestLock()
                let s:test_lock_enabled = 1
            else
                let s:test_lock_enabled = 0
            endif
        augroup END
    endif
endfun

function! <SID>DoTestLock()
    if winnr() == winnr("$")
        return
    endif

    let path = expand("%")

    call ToggleTestLock()           " temporarily disable so we don't loop
    exec winnr("$") . "wincmd w"
    exec ":e " . FindTestFile(path)
    wincmd p
    call ToggleTestLock()           " re-enable
endfunction

function! TestRunnerCommand(path)
    let runner = b:test_runner
    return runner . " " . a:path
endfunction

function! FindTestMethod(path, cursor)
    return a:path
endfunction

function! FindTestFile(path)
    return a:path
endfunction

function! FindTestSuite(path)
    return a:path
endfunction

function! RunTestSuite(path)
    return RunTestFile(FindTestFile(path))
endfunction
