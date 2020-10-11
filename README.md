Learning how to use Git with Vim
================================

Author:   Ernie Lin
Created:  2018/05/18
Modified: 2020/10/10

Instead of adding plugins for Vim 1 by 1, we can use Git to clone the plugins into
submodules. Whenever an update is needed, we just need to type a command and voilà!
This will definitely make our experience in Vim much more blistful.


Installation
============

1. Seting up our Git init:
```
$ git config --global user.name "<user_name>"
$ git config --global user.email "<user_email>"
$ git remote add origin <your_remote_repo>
$ git config --global core.editor "vim"
$ git config --global core.ignorecase false
$ git config --global core.excludesfile "~/.gitignore"
$ git config --global color.ui true
```

2. Building up our Vim in Git repo as submodules by typing:
$ git submodule add <git_repo> <path_to_submodule>
```
$ mkdir -p ~/.vim/plugins
$ mkdir -p ~/.vim/pack/{addons,colors,syntaxes,objects}/{start,opt}
$ cd ~/.vim; git init
$ git commit -am "Initiate Vim”

[1]
$ cd ~/.vim

$ git submodule add https://github.com/dracula/vim.git plugins/dracula
$ ln -s plugins/dracula pack/colors/opt/dracula
$ git commit -am "Add Dracula"

$ git submodule add https://github.com/sjl/badwolf.git plugins/badwolf
$ ln -s plugins/badwolf pack/colors/opt/badwolf
$ git commit -am "Add Badwolf"

$ git submodule add https://github.com/lifepillar/vim-solarized8.git plugins/solarized8
$ ln -s plugins/solarized8 pack/colors/opt/solarized8
$ git commit -am "Add Solarized8"

$ git submodule add https://github.com/ryanoasis/vim-devicons plugins/vimdevicons
$ ln -s plugins/vimdevicons pack/addons/start/vimdevicons
$ git commit -am "Add VimDevIcons"

$ git submodule add https://github.com/scrooloose/nerdtree.git plugins/nerdtree
$ ln -s plugins/nerdtree pack/addons/start/nerdtree
$ git commit -am "Add NERDTree"

$ git submodule add https://github.com/Xuyuanp/nerdtree-git-plugin.git plugins/nerdtree-git-plugin
$ ln -s plugins/nerdtree-git-plugin pack/addons/start/nerdtree-git-plugin
$ git commit -am "Add NERDTree-git-plugin"

$ git submodule add https://github.com/tpope/vim-surround.git plugins/surround
$ ln -s plugins/surround pack/syntaxes/start/surround
$ git commit -am "Add Surround"

$ git submodule add https://github.com/tpope/vim-fugitive.git plugins/fugitive
$ ln -s plugins/fugitive pack/addons/start/fugitive
$ git commit -am "Add Fugitive"

$ git submodule add https://github.com/w0rp/ale.git plugins/ale
$ ln -s plugins/ale pack/syntaxes/start/ale
$ git commit -am "Add ALE"

```
[2]

3. This is not the end:
a. If this is your first time pushing, refer to Github web for further instructions.
b. Now you will have to push them up to your own repo, jump to the second line of the following command.
```
$ git remote add origin youruser@yourserver.com:/path/to/my_project.git
$ git push -u origin master
```

4. Don't forget to load helptags:
```
:helptags ALL
```

* Caveats:
[1] Avoid using abbreviated absolute path as it may interfere with submodules update.
[2] More addons such as VimCompletesMe, fzf, indentguides, workspace, repeat

5. Updating submodules:
```
$ git submodule update --remote --merge
$ git commit
```

6. In an already existing (cloned) repository, you need to initialize
the submodules first and -- usually -- switch to the main branch.
The best I could find is the following:
```
$ git submodule update --init --recursive
$ git submodule foreach --recursive git checkout master
$ git submodule foreach --recursive git pull
```

7. Individually, checking changes before updating:
```
cd <path_to_submodule>
git fetch origin master
git diff
git merge
```

OR

8. Individually, without checking:
```
cd <path_to_submodule>
git submodule update --remote --merge
```

9. Deleting a submodule
```
a. Unregister submodule by:
    'git submodule deinit <path_to_submodule>' (no trailing slash).
b. Delete submodule by:
    'git rm -r <path_to_submodule>' (no trailing slash).
c. Remove submodule cache by:
    'rm -rf .git/modules/<path_to_submodule>'
d. Commit:
	'git commit -m "Remove <submodule_name>"'.
```
