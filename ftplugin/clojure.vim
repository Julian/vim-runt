function! IsClojureTestFile(path)
    " XXX: Make me search the path given as an argument, not the current buffer
    return search('(deftest ', 'nw')
endfunction
let b:runt_is_test_file = 'IsClojureTestFile'

function! FindClojureTestFile(path)
    let parent = fnamemodify(a:path, ":h")
    let tests = substitute(parent, '/src/', '/test/', '')
    let name = fnamemodify(a:path, ':t:r')
    let extension = fnamemodify(a:path, ':e')
    let possible_locations = [
    \   tests . '/' . name . '_test.' . extension,
    \   ]

    echom possible_locations[0]
    for test_file in possible_locations
        if filereadable(test_file)
            return test_file
        endif
    endfor
endfunction
let b:runt_find_test_file_for = 'FindClojureTestFile'
