deploy:
	docker build . -t server

dev:
	python3 server.py

start:
	./dist/dist/server

init:
	rm -rf venv
	rm -rf dist/
	python3 -m venv venv
	. venv/bin/activate
	pip3 install -r requirements.txt
