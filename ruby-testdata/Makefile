include default.mk

CCK_PATH = $(shell bundle exec ruby -e "puts File.expand_path(File.join(Cucumber::CompatibilityKit.examples_path, '..'))" -r 'cucumber-compatibility-kit')
CCK_FEATURES=$(call rwildcard,$(CCK_PATH)/features,*.feature)
FEATURES=$(patsubst $(CCK_PATH)/%,%,$(CCK_FEATURES))
STEP_DEFINITIONS=$(patsubst %,%.rb,$(FEATURES))
JSONS_GOLDEN  = $(patsubst features/%,features/%.json,$(FEATURES))

.tested: $(JSONS_GOLDEN)

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

features/%-unprocessed.json: features/% features/%.rb
	-bundle exec cucumber $< --require $(patsubst %-unprocessed.json,%.rb,$@) --tags "not @exclude-json-formatter" --format=json > $@

features/%.rb: $(CCK_PATH)/features/%.rb
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@

features/%.feature: $(CCK_PATH)/features/%.feature
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@

clean:
	rm -f $(FEATURES) $(STEP_DEFINITIONS) $(JSONS_GOLDEN) features/all.json
