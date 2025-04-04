ENV_DEPS += install-webapi
PYDEPS_WEBAPI += \
	'yhttp-markdown >= 2.0.0'


YHTTP_MARKDOWN ?= $(PREFIX)/bin/yhttp-markdown
WEBAPIDOC_PATH ?= $(HERE)/apidoc
YHTTP_MARKDOWN_FLAGS += \
	--directory $(WEBAPIDOC_PATH)


.PHONY: webapidoc-serve
webapidoc-serve:
	$(YHTTP_MARKDOWN) $(YHTTP_MARKDOWN_FLAGS) serve
