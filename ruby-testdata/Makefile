CCK_PATH = $(shell bundle show cucumber-compatibility-kit)
CCK_FEATURES=$(wildcard $(CCK_PATH)/features/*)
FEATURES=$(patsubst $(CCK_PATH)/features/%,%,$(CCK_FEATURES))
UNSUPPORTED=pending rules skipped unknown-parameter-type markdown retry
SUPPORTED_FEATURES=$(filter-out $(UNSUPPORTED), $(FEATURES))
JSONS_GOLDEN  = $(foreach feature, $(SUPPORTED_FEATURES), features/$(feature)/$(feature).feature.json)
NDJSONS = $(patsubst %.json,%.ndjson,$(JSONS_GOLDEN))
BUNDLE_GEMFILE=$(shell pwd)/Gemfile 

default: $(JSONS_GOLDEN) $(NDJSONS) Gemfile.lock
.PHONY: default

Gemfile.lock: Gemfile
	bundle install
	touch @

features/%.json: features/%-unprocessed.json
	cat $< | \
		./neutralize-json | \
		jq --sort-keys "." > $@

features/%-unprocessed.json: $(CCK_PATH)/features/%
	$(eval feature = $(shell realpath $< --relative-to $(CCK_PATH)))
	$(eval stepdef = $<.rb)
	mkdir -p $(@D)
	-cd $(CCK_PATH) && \
		CUCUMBER_PUBLISH_QUIET=true \
			BUNDLE_GEMFILE=$(BUNDLE_GEMFILE) \
			bundle exec cucumber $(feature) --require $(stepdef) --format=json > $(abspath $@)

features/%.ndjson: $(CCK_PATH)/features/%.ndjson
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@

clean:
	rm -rf features
