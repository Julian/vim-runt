function! IsRustTestFile(path)
    return 1
endfunction
let b:runt_is_test_file = 'IsRustTestFile'

function! RunRustTestFile(path)
    return 'cargo test'
endfunction
let b:runt_file = 'RunRustTestFile'
