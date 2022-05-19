CCK_PATH = $(shell bundle show cucumber-compatibility-kit)
CCK_FEATURES=$(wildcard $(CCK_PATH)/features/**/*.feature)
FEATURES=$(patsubst $(CCK_PATH)/%,%,$(CCK_FEATURES))
STEP_DEFINITIONS=$(patsubst %,%.rb,$(FEATURES))
JSONS_GOLDEN  = $(patsubst features/%,features/%.json,$(FEATURES))
NDJSONS = $(patsubst features/%,features/%.ndjson,$(FEATURES))
BUNDLE_GEMFILE=$(shell pwd)/Gemfile 

default: $(JSONS_GOLDEN) $(NDJSONS)
.PHONY: default

features/%.json: features/%-unprocessed.json
	cat $< | \
		./neutralize-json | \
		jq --sort-keys "." > $@

# Dirty hack: the Ruby version we use do not support some features.
features/pending/pending.feature.json:
	mkdir -p $(@D)
	echo "[]" > $@

features/rules/rules.feature.json:
	mkdir -p $(@D)
	echo "[]" > $@

features/skipped/skipped.feature.json:
	mkdir -p $(@D)
	echo "[]" > $@

features/unknown-parameter-type/unknown-parameter-type.feature.json:
	mkdir -p $(@D)
	echo "[]" > $@

features/%-unprocessed.json: $(CCK_PATH)/features/%
	$(eval feature = $(shell realpath $< --relative-to $(CCK_PATH)))
	$(eval stepdef = $<.rb)
	-cd $(CCK_PATH) && \
		CUCUMBER_PUBLISH_QUIET=true \
			BUNDLE_GEMFILE=$(BUNDLE_GEMFILE) \
			bundle exec cucumber $(feature) --require $(stepdef) --format=json > $(abspath $@)

features/%.rb: $(CCK_PATH)/features/%.rb
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@
.PRECIOUS: features/%.rb

features/%.feature: $(CCK_PATH)/features/%.feature
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@
.PRECIOUS: features/%.feature

features/%.ndjson: $(CCK_PATH)/features/%.ndjson
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@

clean:
	rm -f $(FEATURES) $(STEP_DEFINITIONS) $(JSONS_GOLDEN) $(NDJSONS) features/all.json
