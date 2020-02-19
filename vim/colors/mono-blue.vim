if !has('gui_running') && &t_Co != 256
  finish
endif

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "mono-blue"

" From https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
        \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
        \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
        \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
        \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
        \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
        \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
        \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

let s:light_slate     = { "gui": "#c7d0de", "cterm": "188" }
let s:dark_slate      = { "gui": "#97a7c2", "cterm": "109" }
let s:very_dark_slate = { "gui": "#212a39", "cterm": "17"  }
let s:black           = { "gui": "#000000", "cterm": "16"  }

" TODO light/dark
let s:normal = s:light_slate
let s:literal = s:light_slate

let s:gui_bg = s:very_dark_slate
let s:gui_fg = s:light_slate

" Styles
let s:italic = { "gui": "italic", "cterm": "italic" }
let s:bold   = { "gui": "bold",   "cterm": "bold"   }

call s:h("EndOfBuffer", { "fg": s:black })

call s:h("Normal", { "fg": s:normal })
hi! link NonText   Normal
hi! link Directory Normal
hi! link Directory Normal

hi! link Conditional Normal
hi! link Repeat      Normal
hi! link Label       Normal
hi! link Operator    Normal
hi! link Keyword     Normal
hi! link Statement   Normal
hi! link Type        Normal
hi! link Constant    Normal

call s:h("String", extend({ "fg": s:literal }, s:italic ))
hi! link Character String
hi! link Number    String
hi! link Boolean   String
hi! link Float     String

call s:h("VertSplit", { "bg": s:gui_bg })
hi! link ColorColumn VertSplit
hi! link TabLine VertSplit
hi! link ColorColumn VertSplit
