let b:test_runner = expand("$PYTHON_TEST_RUNNER")

function! b:runt_is_test_file(path)
    " XXX: Make me search the path given as an argument, not the current buffer
    return search("^class \\i*(.*TestCase.*)", "nw")
endfunction

function! b:runt_find_file(path)
    let path = a:path
    let parent = fnamemodify(path, ":h")

    for test_file in [
    \   parent . "/tests/test_" . fnamemodify(path, ":t"),
    \   parent . "/tests.py"
    \   ]
        if filereadable(test_file)
            return test_file
        endif
    endfor

    echoerr "Couldn't find a test file for '" . path . "'"

endfunction

function! b:runt_find_suite(path)
    return "tox -e py27"
endfunction
