RAILS_ENV = test
BUNDLER_VERSION = 1.13.1
BUNDLE = RAILS_ENV=${RAILS_ENV} bundle _${BUNDLER_VERSION}_
BUNDLE_OPTIONS = --jobs=3
RSPEC = rspec
APPRAISAL = appraisal

all: test

test: bundler appraisal
	${BUNDLE} exec ${APPRAISAL} ${RSPEC} spec 2>&1

bundler:
	gem list -i -v ${BUNDLER_VERSION} bundler > /dev/null || gem install bundler --no-ri --no-rdoc --version=${BUNDLER_VERSION}
	${BUNDLE} install ${BUNDLE_OPTIONS}

appraisal:
	${BUNDLE} exec ${APPRAISAL} install