" Highlight SQL inside python strings
unlet b:current_syntax
syntax include @SQL syntax/sql.vim
" This is fugly, but I cannot make it work any other way. The following
" regions take care of highlighting SQL inside single-quoted strings.
syntax region pythonSqlString matchgroup=SQL start=/['"]select /rs=s,hs=s+1 end=/$/ contained containedin=pythonString,pythonRawString contains=@SQL
syntax region pythonSqlString matchgroup=SQL start=/['"]insert /rs=s,hs=s+1 end=/$/ contained containedin=pythonString,pythonRawString contains=@SQL
syntax region pythonSqlString matchgroup=SQL start=/['"]update /rs=s,hs=s+1 end=/$/ contained containedin=pythonString,pythonRawString contains=@SQL

" These regions take care of highlighting SQL inside multi-line strings.
syntax region pythonSqlString matchgroup=SQL start=/ select /rs=s end=/^\s*$/ contained containedin=pythonString,pythonRawString contains=@SQL
syntax region pythonSqlString matchgroup=SQL start=/ insert /rs=s end=/^\s*$/ contained containedin=pythonString,pythonRawString contains=@SQL
syntax region pythonSqlString matchgroup=SQL start=/ update /rs=s end=/^\s*$/ contained containedin=pythonString,pythonRawString contains=@SQL
