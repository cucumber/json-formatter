include default.mk

CCK_PATH = ./node_modules/@cucumber/compatibility-kit
CCK_FEATURES=$(call rwildcard,$(CCK_PATH)/features,*.feature)
FEATURES=$(patsubst $(CCK_PATH)/%,%,$(CCK_FEATURES))
STEP_DEFINITIONS=$(patsubst %,%.ts,$(FEATURES))
NDJSONS_GOLDEN  = $(patsubst features/%,features/%.ndjson,$(FEATURES))

.tested: $(NDJSONS_GOLDEN)

.built: $(STEP_DEFINITIONS)

# Dirty hack: the Ruby version we use do not support some features.
features/pending/pending.feature.ndjson:
	mkdir -p $(@D)
	echo "" > $@

features/rules/rules.feature.ndjson:
	mkdir -p $(@D)
	echo "" > $@

features/skipped/skipped.feature.ndjson:
	mkdir -p $(@D)
	echo "" > $@

features/unknown-parameter-type/unknown-parameter-type.feature.ndjson:
	mkdir -p $(@D)
	echo "" > $@

features/%.ndjson: features/% features/%.ts
	npx fake-cucumber/javascript/scripts/fake-cucumber.sh \
		--predictable-ids \
		$< > $@

features/%.ts: $(CCK_PATH)/features/%.ts
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@

features/%.feature: $(CCK_PATH)/features/%.feature
	mkdir -p $(@D)
	cp $(patsubst %,$(CCK_PATH)/%,$@) $@

clean:
	rm -f $(FEATURES) $(STEP_DEFINITIONS) $(NDJSONS_GOLDEN)
