# vim

sh setting
======================


### setting ###
```sh
~ % cd $HOME/
~ % git clone https://github.com/nsm0/vim.git .vim
~ %
~ % cd .vim/
.vim % git submodule init
.vim % git submodule update
.vim %
.vim % cd $HOME/

~ % # vimproc_mac.so is not found 対策
~ % cd ~/.vim/bundle/vimproc
vimproc % make
vimproc %

.vimproc % cd $HOME/
~ % ln -s .vim/.vimrc .

```
