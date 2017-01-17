current_dir:=$(shell pwd)

version:
	@echo [INFO] [version]
	@echo [INFO]    Build Makefile Version 1.00

help: version
	@printf "\e[1;34m[INFO] [information]\e[00m\n\n"
	@echo [INFO] This make process supports the following targets:
	@echo [INFO]    build   - build both the project and Docker image
	@echo [INFO]    install - install the application
	@echo [INFO]    run     - run the service locally in development environment
	@echo [INFO]    daemon  - run the service as a daemon locally in development environment
	@echo
	@echo [INFO] This tool expects the project to be located in a directory called image.
	@echo [INFO] If there is a Makefile in the image directory, then this tool will execute it
	@echo [INFO] with either clean and build targets.
	@echo
	@echo [INFO] Run as service with ports in interactive mode:
	@echo [INFO]
	@echo [INFO]     make run

build: version
	bundle

install: build
	sudo update-rc.d -f dyn_dns remove
	sudo cp dyn_dns.sh /etc/init.d/dyn_dns
	sudo chmod 755 /etc/init.d/dyn_dns
	sudo update-rc.d dyn_dns defaults

run: version
	ruby dyn_dns.rb --daemonize=false

daemon: version
	/usr/local/bin/ruby dyn_dns.rb --daemonize=true