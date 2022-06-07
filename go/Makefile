include default.mk

GOLDEN_JSONS = $(wildcard ../testdata/features/**/*.json)
GENERATED_JSONS = $(patsubst ../testdata/features/%.json,acceptance/%.json,$(GOLDEN_JSONS))

.DELETE_ON_ERROR:

.tested: $(GENERATED_JSONS)

acceptance/%.json: ../testdata/features/%.ndjson $(EXE) ../testdata/features/%.json
	mkdir -p $(@D)
	cat $< | \
		$(EXE) | \
		../testdata/neutralize-json | \
		jq --sort-keys "." > \
		$@
	diff --unified $(word 3, $^) $@
