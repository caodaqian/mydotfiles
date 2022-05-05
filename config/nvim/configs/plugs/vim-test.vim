" -- vim-test setting ---------------------------------------------------
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
let g:ultest_virtual_text = 1
let g:ultest_pass_sign = ""
let g:ultest_fail_sign = ""
let g:ultest_running_sign = ""
let g:ultest_not_run_sign = "?"
let g:ultest_max_threads = 12
let g:ultest_output_on_line = 0
let g:ultest_use_pty = 1
