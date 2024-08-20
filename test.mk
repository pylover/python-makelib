PYTEST ?= $(PREFIX)/bin/pytest
COVERAGE ?= $(PREFIX)/bin/coverage
TEST_DIR = tests
PYTEST_FLAGS += -v
QA += cover
PYDEPS_COMMON += \
	coverage \
	pytest-cov


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
	$(PYTEST) $(PYTEST_FLAGS) --cov=$(PKG_NAMESPACE) $(TEST_FILTER)


.PHONY: cover-html
cover-html: cover
	$(COVERAGE) html
	@echo "Browse htmlcov/index.html for the covearge report"
