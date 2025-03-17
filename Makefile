# Makefileのあるディレクトリをドットファイルのパスとする
DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
# remove . and ..
DOTFILES := $(wildcard .??*)
EXCULUSIONS := .git .gitignore .tmux
DOTFILES := $(filter-out $(EXCULUSIONS), $(DOTFILES))

# color
RED        := $(shell tput setaf 1)
NOCOLOR    := $(shell tput sgr0)

# @: コマンドを表示しない
list: # show dotfiles
	# -d: directory themeslves, -F: append indicator
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

clean:
	@echo 'remove symbolic links'
	$(foreach val, $(DOTFILES), rm -rf $(HOME)/$(val);)
	rm -rf "$(HOME)/.zplug"
	rm -rf "$(HOME)/.zprezto"
	rm -rf "$(HOME)/.zlogin"
	rm -rf "$(HOME)/.zlogout"
	rm -rf "$(HOME)/.zpreztorc"
	rm -rf "$(HOME)/.zprofile"
	rm -rf "$(HOME)/.zshenv"
	@echo 'done'

# install: init link node done
install: init link done # without node

init: # minimum setup
	bash $(DOTPATH)/scripts/init.sh

link: # make symbolic link under home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

node:
	zsh $(DOTPATH)/scripts/node.sh

done:
	@echo ""
	@echo "Finish install!"
	@echo "Please run $(RED)chsh -s $$(which zsh) and logout$(NOCOLOR)"
	@echo ""

help: # Makefile doc
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
