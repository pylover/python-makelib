ENV_DEPS += install-webapi
PYDEPS_WEBAPI += \
	'yhttp-markdown >= 1.0.1'


YHTTP_MARKDOWN ?= $(PREFIX)/bin/yhttp-markdown
WEBAPIDOC_PATH ?= $(HERE)/apidoc
YHTTP_MARKDOWN_FLAGS += \
	--directory $(WEBAPIDOC_PATH)


.PHONY: webapidoc-serve
webapidoc-serve:
	$(YHTTP_MARKDOWN) $(YHTTP_MARKDOWN_FLAGS) serve
