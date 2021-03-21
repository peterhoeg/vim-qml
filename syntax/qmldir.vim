if exists("b:current_syntax")
    finish
endif

syntax match QmlDirComponentName '\([A-Z]\w\+\)' contains=NONE
syntax match QmlDirComponentVersion '[0-9]\.[0-9]\+' contains=NONE
syntax match QmlDirKeywords '\(^singleton\|^module\|internal\|plugin\|typeinfo\|classname\|depends\)' contains=NONE
syntax match QmlDirComment '^#.*$' contains=NONE
syntax match QmlDirModuleName '[aA-zZ]\w\+\.[aA-zZ]\w\+.*$' contains=NONE
syntax match QmlDirFileName '\([A-Z]\w\+\)\(\.qml\)' contains=NONE

highlight default link QmlDirComponentName Type
highlight default link QmlDirComponentVersion Number
highlight default link QmlDirKeywords Keyword
highlight default link QmlDirComment Comment
highlight default link QmlDirFileName Normal
highlight default link QmlDirModuleName Tag

let b:current_syntax = "qmldir"
