if !has('gui_running') && &t_Co != 256
  finish
endif

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "bw"

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

let s:grey0  = { "gui": "#080808", "cterm": "232" } " Darkest
let s:grey1  = { "gui": "#121212", "cterm": "233" }
let s:grey2  = { "gui": "#1c1c1c", "cterm": "234" }
let s:grey3  = { "gui": "#262626", "cterm": "235" }
let s:grey4  = { "gui": "#303030", "cterm": "236" }
let s:grey5  = { "gui": "#3a3a3a", "cterm": "237" }
let s:grey6  = { "gui": "#444444", "cterm": "238" }
let s:grey7  = { "gui": "#4e4e4e", "cterm": "239" }
let s:grey8  = { "gui": "#585858", "cterm": "240" }
let s:grey9  = { "gui": "#626262", "cterm": "241" }
let s:grey10 = { "gui": "#6c6c6c", "cterm": "242" }
let s:grey11 = { "gui": "#767676", "cterm": "243" } " Middlest
let s:grey12 = { "gui": "#808080", "cterm": "244" }
let s:grey13 = { "gui": "#8a8a8a", "cterm": "245" }
let s:grey14 = { "gui": "#949494", "cterm": "246" }
let s:grey15 = { "gui": "#9e9e9e", "cterm": "247" }
let s:grey16 = { "gui": "#a8a8a8", "cterm": "248" }
let s:grey17 = { "gui": "#b2b2b2", "cterm": "249" }
let s:grey18 = { "gui": "#bcbcbc", "cterm": "250" }
let s:grey19 = { "gui": "#c6c6c6", "cterm": "251" }
let s:grey20 = { "gui": "#d0d0d0", "cterm": "252" }
let s:grey21 = { "gui": "#dadada", "cterm": "253" }
let s:grey22 = { "gui": "#e4e4e4", "cterm": "254" }
let s:grey23 = { "gui": "#eeeeee", "cterm": "255" } " Lightest

let s:black  = { "gui": "#000000", "cterm": "16"  }
let s:white  = { "gui": "#ffffff", "cterm": "15"  }

let s:red    = { "gui": "#ac333b", "cterm": "124"  }

let s:dark_mode  = "dark"
let s:light_mode = "light"

" TODO update dynamically or whatever
let s:mode = s:dark_mode

if s:mode == s:dark_mode
  " Background is #FFFFF
  let s:normal   = s:grey18
  let s:literal  = s:grey15
  let s:comment  = s:grey16
  let s:special  = s:white
  let s:stmt     = s:white
  let s:line_num = s:grey11

  let s:gui_bg = s:grey1
  let s:gui_fg = s:grey19

  let s:gui_bg_highlight = s:grey20
  let s:gui_fg_highlight = s:grey0

  let s:todo_bg = s:grey7
  let s:visual_bg = s:grey6
  let s:pmenu_bg = s:grey2

  " If StatusLine and StatusLineNC are the same, vim puts '^'s in the active
  " buffers status line.  If we change the gui color just a little then it won't
  " do that
  let s:status_line_hack = { "gui": "#121211", "cterm": "233" }

  let s:invisible = s:black
  let s:obnoxious = s:white
else
  " Background is #FFFFF
endif

" Styles
let s:italic    = { "gui": "italic",    "cterm": "italic"      }
let s:bold      = { "gui": "bold",      "cterm": "bold"        }
let s:underline = { "gui": "underline", "cterm": "underline"   }

let s:none = {}

call s:h("EndOfBuffer", { "fg": s:invisible })

call s:h("Normal", { "fg": s:normal })
hi! link NonText   Normal

call s:h("Conditional", { "fg": s:stmt })
hi! link Repeat      Conditional
hi! link Label       Conditional
hi! link Operator    Conditional
hi! link Keyword     Conditional
hi! link Statement   Conditional
hi! link Type        Conditional
hi! link Title       Conditional
hi! link Identifier  Conditional
hi! link Function    Conditional
hi! link PreProc     Conditional
hi! link Include     Conditional
hi! link Define      Conditional
hi! link Macro       Conditional
hi! link PreCondit   Conditional

call s:h("String", { "fg": s:literal })
hi! link Character String
hi! link Number    String
hi! link Boolean   String
hi! link Float     String
hi! link Constant  String

call s:h("VertSplit", { "bg": s:gui_bg })
hi! link ColorColumn VertSplit
hi! link TabLine VertSplit
hi! link TabLineFill VertSplit
hi! link ColorColumn VertSplit
hi! link StatusLine VertSplit
call s:h("StatusLineNC", { "bg": s:status_line_hack })

call s:h("Special", { "fg": s:special })
hi! link SpecialKey     Special
hi! link Tag            Special
hi! link SpecialChar    Special
hi! link Delimiter      Special
hi! link SpecialComment Special
hi! link Debug          Special
hi! link Directory      Special

call s:h("MatchParen", { "bg": s:red })

call s:h("PMenu",      { "bg": s:pmenu_bg                                   })
call s:h("PMenuSel",   { "fg": s:gui_fg_highlight, "bg": s:gui_bg_highlight })
call s:h("PMenuSbar",  { "bg": s:pmenu_bg                                   })
call s:h("PMenuThumb", { "bg": s:gui_bg_highlight                           })
hi! link WildMenu PMenuSel

call s:h("Todo", { "fg": s:stmt, "bg": s:todo_bg })
call s:h("Visual", { "bg": s:visual_bg })
hi! link CursorLine Visual

call s:h("Underlined", extend( { "fg": s:special}, s:underline))

call s:h("Search", { "fg": s:invisible, "bg": s:obnoxious })
hi! link QuickFixLine Search

call s:h("Comment", { "fg": s:comment })

call s:h("LineNr", { "fg": s:line_num })
call s:h("CursorLineNr", { "fg": s:obnoxious })

call s:h("SpellBad", s:underline)
hi! link SpellRare  SpellBad
hi! link SpellLocal SpellBad

" More annoying than helpful, just hide it
call s:h("SpellCap", s:none)
