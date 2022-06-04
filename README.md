Learning how to use Vim with Git
================================

Author:   Ernie Lin	| Created:  2018/05/18 | Modified: 2021/11/27

Building your own Vim from ground level and having a blisfull exprience.
Git all desired submodules to speed up the future upgrades.

Installation
============

1. Setting up our Git init:
```
$ git config --global user.name "<user_name>"
$ git config --global user.email "<user_email>"
$ git config --global core.editor "vim"
$ git config --global core.excludesfile "~/.gitignore"
$ git remote add origin <your_remote_repo>
```

2. Building up our Vim in Git by typing: 'git submodule add <git_repo> <path_to_submodule>'.
```
$ mkdir -p ~/.vim/pack/addons/{start,opt}
$ cd ~/.vim; git init
$ git commit -am "Initiate Vim”
$ cd ~/.vim

$ git submodule add https://github.com/dense-analysis/ale.git ./pack/addons/start/ale
$ git commit -am "Add ALE"

$ git submodule add https://github.com/ryanoasis/vim-devicons ./pack/addons/start/vim-devicons
$ git commit -am "Add Vim-DevIcons"

$ git submodule add https://github.com/tpope/vim-fugitive.git ./pack/addons/start/vim-fugitive
$ git commit -am "Add Vim-Fugitive"

$ git submodule add https://github.com/tpope/vim-surround.git ./pack/addons/start/vim-surround
$ git commit -am "Add Vim-Surround"

$ git submodule add https://github.com/junegunn/fzf.vim.git ./pack/addons/start/fzf.vim
$ git commit -am "Add fzf.vim"

$ git submodule add https://github.com/altercation/vim-colors-solarized.git .pack/addons/opt/solarized.vim
$ git commit -am "Add color Solarized"

$ git submodule add https://github.com/morhetz/gruvbox.git ./pack/addons/opt/gruvbox.vim
$ git commit -am "Add color Gruvbox"

$ git submodule add https://github.com/nanotech/jellybeans.vim.git ./pack/addons/opt/jellybeans.vim
$ git commit -am "Add color Jellybeans"

$ git submodule add https://github.com/sjl/badwolf.git ./pack/addons/opt/badwolf.vim
$ git commit -am "Add color Badwolf"

```

3. (a) This is not the END! If this is your first time uploading your files from 0, you will have to push
them up to your own repo.
```
$ git remote add origin youruser@yourserver.com:/path/to/my_project.git
$ git push -u origin master
```

OR

3. (b) In case you already have the existing repository, you need to initialize
the submodules first and -- usually -- switch to the main branch.
```
$ git submodule update --init --recursive
$ git submodule foreach --recursive git checkout master
$ git submodule foreach --recursive git pull
```
* Caveats: Use relative path with git commands to avoid submodules mismanage.

4. Don't forget to load helptags:
```
:helptags ALL
```

5. Updating submodules:
```
$ git submodule update --remote --merge
$ git commit
```

6. (a) Individually, checking changes before updating:
```
cd <path_to_submodule>
git fetch origin master
git diff
git merge
```

OR

6. (b) Individually, without checking:
```
cd <path_to_submodule>
git submodule update --remote --merge
```

7. Deleting a no-wanted-anymore submodule:
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
