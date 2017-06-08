ifdef VERSION
	project_version:=$(VERSION)
else
	project_version:=$(shell git rev-parse --short=8 HEAD)
endif

ifdef PROJECT_NAME
	project_name:=$(PROJECT_NAME)
else
	project_name:=$(shell echo $(shell echo $(shell basename $(shell dirname $(CURDIR))) | perl -pe 's/([a-z0-9])([A-Z])/$$1_\\$$2/g') | tr '[:upper:]' '[:lower:]')
endif

ifdef SRC_DIR
	source_directory:=$(SRC_DIR)
else
	source_directory:=$(CURDIR)
endif

version:
	@printf "\e[1;34m[INFO] [version]\e[00m\n\n"
	@echo [INFO] Project Makefile Version 2.0:
	@echo

settings: version
	@printf "\e[1;34m[INFO] [settings]\e[00m\n\n"
	@echo [INFO] 	project_version=$(project_version)
	@echo [INFO] 	project_name=$(project_name)
	@echo [INFO] 	source_directory=$(source_directory)
	@echo

help: settings
	@printf "\e[1;34m[INFO] [information]\e[00m\n\n"
	@echo [INFO] This make process supports the following targets:
	@echo [INFO]    clean     - (chef, jenkins) clean up and targets in project
	@echo [INFO]    build     - (chef, jenkins) build both the project and Docker image
	@echo [INFO]    lint      - (chef) Example: JSLint, Lint etc...
	@echo [INFO]    syntax    - (chef) Example: Checkstyle
	@echo [INFO]    unit      - (chef) Example: Respec, Java Unit Test
	@echo [INFO]    security  - (chef) Example: Fortify
	@echo [INFO]    quality   - (chef) Run validate image.
	@echo
	@echo [INFO] The script supports the following parameters:
	@echo [INFO] 	VERSION - version to tag docker image wth, default value is the git hash
	@echo [INFO] 	PROJECT_NAME - project name, default is git project name
	@echo
	@echo [INFO] This will build the  project.
	@echo
	@echo [INFO] Examples:
	@echo
	@echo [INFO]	make build
	@echo
	@echo [INFO]	make build VERSION=666 PROJECT_NAME=dark_place
	@echo

clean: settings
	@printf "\e[1;34m[INFO] [cleaning $(project_name)]\e[00m\n\n"

build: settings
	@printf "\e[1;34m[INFO] [building $(project_name)]\e[00m\n\n"
	cd $(source_directory)/app; bundle
	cd $(source_directory)/app; ruby build_version.rb --version=$(project_name)-$(project_version)

lint: settings
	@printf "\e[1;34m[INFO] [linting $(project_name)]\e[00m\n\n"
	@printf "\e[1;34m[WARNING] [linting $(project_name)]\e[00m\n\n"

syntax: settings
	@printf "\e[1;34m[INFO] [syntax check $(project_name)]\e[00m\n\n"
	@printf "\e[1;34m[WARNING] [syntax check $(project_name)]\e[00m\n\n"

unit: settings
	@printf "\e[1;34m[INFO] [unit test $(project_name)]\e[00m\n\n"
	@printf "\e[1;34m[WARNING] [unit test $(project_name)]\e[00m\n\n"

security: settings
	@printf "\e[1;34m[INFO] [security pass on $(project_name)]\e[00m\n\n"
	@printf "\e[1;34m[WARNING] [security pass on $(project_name)]\e[00m\n\n"
