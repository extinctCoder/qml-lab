# qml-lab — native Qt dev loop (no Python). Needs: brew install qt
export QT_QUICK_CONTROLS_STYLE := Tui
IMPORTS := -I lib -I shell/sim
FILE ?= gallery/Gallery.qml

.PHONY: run watch lab debug lint

PORT ?= 5050

run:    ## run FILE (default: the gallery)
	qml $(IMPORTS) $(FILE)

watch:  ## run FILE with hot reload
	qmlpreview qml $(IMPORTS) $(FILE)

lab:    ## run the shell lab with hot reload
	$(MAKE) watch FILE=shell/sim/lab.qml

debug:  ## run FILE with the QML debugger listening on PORT; attach from VS Code (F5)
	qml -qmljsdebugger=host:127.0.0.1,port:$(PORT),block,services:DebugMessages,QmlDebugger,V8Debugger,QmlInspector $(IMPORTS) $(FILE)

lint:   ## qmllint the library, shell and gallery
	qmllint $(IMPORTS) $$(find lib shell gallery -name '*.qml')
