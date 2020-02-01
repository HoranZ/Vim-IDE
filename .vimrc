syntax enable 					"开启语法高亮
syntax on 						"开启语法高亮

filetype on 					"检测文件类型
filetype plugin on 				"针对不同文件采取不同缩进方式
filetype indent on 				"允许插件
filetype plugin indent on 		"启动自动补全

set number						"显示行号
set ruler 						"显示当前行号
set showmode 					"显示当前Vim模式
set showcmd 					"显示正在输入的命令
set tabstop=4 					"设置tab宽度
set shiftwidth=4 				"设置自动对齐空格数
set smarttab 					"设置backspace删去tab"
set mouse=a 					"允许鼠标操作
set nobackup 					"取消备份
set noswapfile 					"取消临时文件
set encoding=utf-8 				"设置编码方式
set helplang=cn 				"中文帮助
set completeopt=longest,menu 	"自动补全配置
set wildmenu 					"增强命令行自动完成操作
let mapleader = ","

"pathogen 插件管理
execute pathogen#infect()

autocmd Filetype c setlocal omnifunc=cppcomplete#Complete
autocmd Filetype cpp setlocal omnifunc=cppcomplete#Complete
" search namespaces in the current buffer   and in included files
let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_DisplayMode = 1 		"always show all members

let g:tagbar_width=30               "设置tagbar的宽度
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()              "在某些情况下自动打开tagbar

"Ctrl + n 打开目录树
map <C-n> :NERDTree<CR>
"Ctrl + t 打开 tagbar
map <C-t> :TagbarToggle<CR>
"ctags 生成 cpp 文件的 tags
map <F4> :call CreateTags()<CR>
"<F5> 编译运行
map <F5> :call ComplieAndRun() <CR>
map <ESC><SPACE> :call ComplieAndRun() <CR>
"<F9> 调试
map <F5> :call Rungdb() <CR>
map <leader><ESC><SPACE> :call Rungdb() <CR>
"<F10> 运行
map <F10> :!time ./%< <CR>
map <SPACE><ESC> :!time ./%< <CR>


"编译
set makeprg=clang++\ %\ -std=c++11\ -o\ %<
func! ComplieAndRun()
	exec "w"
	exec "make"
	exec '!time ./%<'
endfunc

"调试
func! Rungdb()
	exec "w"
	exec "!clang++ % -std=c++11 -g -o %<"
	exec "!gdb ./%<"
endfunc

"生成tags文件
func! CreateTags()
	if &filetype == 'c'
		exec "!ctags *.c *.h --c-kinds=+p --fields=+iaS --extras=+fq "
	elseif &filetype == 'cpp'
		exec "!ctags *.cpp *.h *.hpp *.c --c++-kinds=+px --fields=+iaS --extras=+fq "
	elseif &filetype == 'java'
		exec "!ctags *.java --java-kinds=+p --fields=+iaS --extras=+fq "
	elseif &filetype == 'python'
		exec "!ctags *.py --python-kinds --fields=+iaS --extras=+f "
	elseif &filetype == 'html'
		exec "!ctags *.html --html-kinds=+p --fields=+iaS --extras=+f "
	endif
endfunc
