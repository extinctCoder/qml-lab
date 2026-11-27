# qml-lab — native Qt dev loop (no Python). Needs: brew install qt
export QT_QUICK_CONTROLS_STYLE := Tui
IMPORTS := -I lib -I shell/sim
FILE ?= gallery/Gallery.qml

.PHONY: run watch lab lint

run:    ## run FILE (default: the gallery)
	qml $(IMPORTS) $(FILE)

watch:  ## run FILE with hot reload
	qmlpreview qml $(IMPORTS) $(FILE)

lab:    ## run the shell lab with hot reload
	$(MAKE) watch FILE=shell/sim/lab.qml

lint:   ## qmllint the library, shell and gallery
	qmllint $(IMPORTS) $$(find lib shell gallery -name '*.qml')
