" Python Matcher

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

if has('python3')
  execute 'py3file ' . s:plugin_path . '/pymatcher.py'
endif

function! pymatcher#PyMatch(items, str, limit, mmode, ispath, crfile, regex)

    call clearmatches()

    if a:str == ''
        return a:items[0:a:limit]
    endif

    let s:rez = []
    let s:regex = ''

    execute 'python3 CtrlPPyMatch()'

    let s:matchregex = '\v\c'

    if a:mmode == 'filename-only'
        let s:matchregex .= '[\^\/]*'
    endif

    let s:matchregex .= s:regex

    call matchadd('CtrlPMatch', s:matchregex)

    return s:rez
endfunction
