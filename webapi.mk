WEBAPIDOC_PATH ?= $(HERE)/apidoc


.PHONY: webapi-serve
webapi-serve:
	$(PREFIX)/bin/yhttp serve -C $(WEBAPIDOC_PATH)
