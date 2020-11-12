EMACS_COMMAND ?= emacs -Q --batch

index.html: create-index.js index.handlebars data.json
	node create-index.js

data.json: create-data.el
	$(EMACS_COMMAND) -l create-data.el
