PYTEST ?= $(PREFIX)/bin/pytest
TEST_DIR = tests
PYTEST_FLAGS += -v
QA += cover


ifdef F
  TEST_FILTER = $(F)
else
  TEST_FILTER = $(TEST_DIR)
endif


.PHONY: test
test:
	$(PYTEST) $(PYTEST_FLAGS) $(TEST_FILTER)


.PHONY: cover
cover:
	$(PYTEST) $(PYTEST_FLAGS) --cov=$(PKG) $(TEST_FILTER)


.PHONY: cover-html
cover-html: cover
	$(COVERAGE) html
	@echo "Browse htmlcov/index.html for the covearge report"
