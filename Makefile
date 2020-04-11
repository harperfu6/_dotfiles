DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))# Makefileのあるディレクトリをドットファイルのパスとする
DOTFILES := $(wildcard .??*) # remove . and ..
EXCULUSIONS := .git .gitignore
DOTFILES := $(filter-out $(EXCULUSIONS), $(DOTFILES))

# @: コマンドを表示しない
list: # show dotfiles
	@$(foreach val, $(DOTFILES), ls -dF $(val);) # -d: directory themeslves, -F: append indicator

clean:
	@echo 'remove symbolic links'
	@$(foreach val, $(DOTFILES), rm -rf $(HOME)/$(val);)
	@echo 'done'

install: init link done
	# @echo $(SHELL)
	#
init: # minimum setup
	bash $(DOTPATH)/scripts/init.sh

link: # make symbolic link under home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

done:
	@echo ""
	@echo "Finish install!"
	@echo "Please run $(RED)chsh -s $(which zsh) and logout$(NOCOLOR)"
	@echo ""

help: # Makefile doc
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
