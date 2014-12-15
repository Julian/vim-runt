if !exists('b:test_runner')
    let b:test_runner = expand("$PYTHON_TEST_RUNNER")
endif

function! IsPythonTestFile(path)
    " XXX: Make me search the path given as an argument, not the current buffer
    return search("^class \\i*(.*TestCase.*)", "nw")
endfunction
let b:runt_is_test_file = 'IsPythonTestFile'

function! FindPythonTestFile(path)
    let path = a:path
    let parent = fnamemodify(path, ":h")

    for test_file in [
    \   parent . "/tests/test_" . fnamemodify(path, ":t"),
    \   parent . "/test/test_" . fnamemodify(path, ":t"),
    \   parent . "/tests.py"
    \   ]
        if filereadable(test_file)
            return test_file
        endif
    endfor

    echoerr "Couldn't find a test file for '" . path . "'"

endfunction
let b:runt_find_test_file_for = 'FindPythonTestFile'

function! RunPythonTestFile(path)
    return b:test_runner . ' ' . a:path
endfunction
let b:runt_file = 'RunPythonTestFile'
