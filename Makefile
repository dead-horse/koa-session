TESTS = test/*.test.js
REPORTER = tap
TIMEOUT = 3000
MOCHA_OPTS =

install:
	@npm install --registry=http://registry.npm.taobao.org

test:
	@NODE_ENV=test ./node_modules/mocha/bin/mocha \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		--require should \
		--require babel-core/register \
		$(MOCHA_OPTS) \
		$(TESTS)


test-cov:
	@NODE_ENV=test node \
		node_modules/.bin/istanbul cover ./node_modules/.bin/_mocha \
		-- -u exports \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		--require should \
		--require babel-core/register \
		$(MOCHA_OPTS) \
		$(TESTS)

test-travis:
	@NODE_ENV=test node \
		node_modules/.bin/istanbul cover ./node_modules/.bin/_mocha \
		--report lcovonly \
		-- -u exports \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		--require should \
		--require babel-core/register \
		$(MOCHA_OPTS) \
		$(TESTS)

autod:
	@./node_modules/.bin/autod -w -e example --prefix=~ --keep=supertest,debug, --semver=koa@1
	@$(MAKE) install

.PHONY: test
