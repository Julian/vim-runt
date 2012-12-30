let b:test_runner = expand("$PYTHON_TEST_RUNNER")

function! FindTestFile(path)
    let path = a:path
    if search("^class \\i*(TestCase)", "nw")
        return path
    endif

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

function! RunTestSuite(path)
    return "tox -e py27"
endfunction
