WEBAPIDOC_PATH ?= $(HERE)/apidoc


.PHONY: webapi-serve
webapi-serve:
	yhttp serve -C $(WEBAPIDOC_PATH)
