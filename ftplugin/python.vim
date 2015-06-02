if !exists('b:test_runner')
    let b:test_runner = expand("$PYTHON_TEST_RUNNER")
endif

function! IsPythonTestFile(path)
    " XXX: Make me search the path given as an argument, not the current buffer
    return search("^class \\i*(.*TestCase.*)", "nw")
endfunction
let b:runt_is_test_file = 'IsPythonTestFile'

function! FindPythonTestFile(path)
    let canonicalized = substitute(fnamemodify(a:path, ':t'), '^_*', '', '')
    let parent = fnamemodify(a:path, ":h")

    let possible_locations = [
    \   parent . '/tests/test_' . canonicalized,
    \   parent . '/test/test_' . canonicalized,
    \   parent . '/tests.py',
    \   ]

    if parent =~ '\<tests\?\>'
        call add(possible_locations, parent . '/test_' . canonicalized)
    endif

    for test_file in possible_locations
        if filereadable(test_file)
            return test_file
        endif
    endfor
endfunction
let b:runt_find_test_file_for = 'FindPythonTestFile'

function! RunPythonTestFile(path)
    return b:test_runner . ' ' . a:path
endfunction
let b:runt_file = 'RunPythonTestFile'
