.PHONY: build clean release
DIST_DIR := $(CURDIR)/dist

GIT_COMMIT=$(shell git rev-parse HEAD)
VERSION=$(shell autotag -n)
GITHUB_USER="JackKrasn"
GITHUB_REPO="helm-secrets"

default: build

help:
	@echo 'Management commands for helm-secrets:'
	@echo
	@echo 'Usage:'
	@echo '    make build           Package plugin.'

	@echo '    make clean           Clean the directory tree.'
	@echo '    make release         Clean the directory tree.'


build:
	@echo building archive
	mkdir -p ${DIST_DIR}
	gtar --transform 's,^,helm-secrets/,'  --exclude=contrib --exclude=examples --exclude=tests --exclude=dist --exclude=helm-secrets.tar.gz -zcvf ${DIST_DIR}/helm-secret-${VERSION}.tar.gz *

clean:
	@echo "deleting ${DIST_DIR}"
	@rm -rf '$(DIST_DIR)'

release:
	clean
	build
	github-release release -u ${GITHUB_USER} -r ${GITHUB_REPO} -t ${VERSION} -c ${COMMIT} -n ${VERSION}
	github-release upload -u ${GITHUB_USER} -r ${GITHUB_REPO} -t ${VERSION} -n helm-secrets-${VERSION}.tar.gz -f release/helm-secrets-${VERSION}.tar.gz



