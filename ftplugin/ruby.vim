set textwidth=100
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
