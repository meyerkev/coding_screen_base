SHELL = /bin/bash

INTERVIEW ?= foo

venv: venv/touchfile

venv/touchfile: dev_requirements.txt
	test -d venv || bin/venv.sh
	touch venv/touchfile
fix : venv
	. venv/bin/activate
	autopep8 --in-place src/*.py
	make lint
lint : venv
	. ./venv/bin/activate
	pylint src/
clean:
	rm -rf venv
	find . | grep ".pyc$$" | xargs rm || true
docker-pull: FORCE
	docker pull ubuntu:latest
docker-build: FORCE
	docker build --no-cache -t meyerkev-${INTERVIEW?}-interview .
down: FORCE
	docker-compose -f docker-compose.yml -p \
	    meyerkev-${INTERVIEW?}-interview stop \
		meyerkev-${INTERVIEW?}-interview
up: FORCE
	docker-compose -f docker-compose.yml -p \
		meyerkev-${INTERVIEW?}-interview up -d --no-build \
		meyerkev-${INTERVIEW?}-interview
sh: FORCE
	docker-compose -f docker-compose.yml -p \
		meyerkev-${INTERVIEW?}-interview run --rm --service-ports \
		meyerkev-${INTERVIEW?}-interview /bin/bash
reset: down up
test: 
	pytest src/
local: FORCE
	python src/server.py
    
# ref: http://www.gnu.org/software/make/manual/html_node/Force-Targets.html#Force-Targets
FORCE:

