# Approval test data

In this folder, we use [`cucumber-ruby`](github.com/cucumber/cucumber-ruby) to generate "golden master" test data that we use to verify the JSON formatter's output.

We take the features from the [CCK](https://github.com/cucumber/common/tree/main/compatibility-kit) and run `cucumber-ruby` on each of them.

This then gives us, for each CCK feature:

* An `ndjson` of the messages output by a running CCK-compliant Cucumber (copied over from the CCK)
* A `json` formatter output produced by `cucumber-ruby`

These files are used to test the Go implementation. 
