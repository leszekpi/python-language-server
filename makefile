PRJ_NAME=python_language_server
PYTHON_VER=3.6.8

# ----------------------------------------------------------------------------------------
all: venv configure test install-dev


# ----------------------------------------------------------------------------------------
upgrade-pip:
	@pip install -U pip


# ----------------------------------------------------------------------------------------
test: configure install-test upgrade-pip
	@pytest


# ----------------------------------------------------------------------------------------
install-test:upgrade-pip
	@pip install -U -e .[test]


# ----------------------------------------------------------------------------------------
install-dev: upgrade-pip
	@pip install -U -e .[all]


# ----------------------------------------------------------------------------------------
configure: upgrade-pip
	@pip install -U -e .[all]


# ----------------------------------------------------------------------------------------
venv:
	pyenv virtualenv-delete -f $(PRJ_NAME)
	pyenv virtualenv $(PYTHON_VER) $(PRJ_NAME)
	pyenv local $(PRJ_NAME)


# ----------------------------------------------------------------------------------------
update-requirements: venv configure
	@pip freeze > requirements.txt


# ----------------------------------------------------------------------------------------
# Clean all __pycache__ directories
clean:
	@find . -depth -type d -name '__pycache__' -exec rm -rf {} \;
	@find . -depth -type d -name '.cache' -exec rm -rf {} \;
	@find . -depth -type d -name '.eggs' -exec rm -rf {} \;
	@find . -depth -type d -name '.pytest_cache' -exec rm -rf {} \;
	@find . -depth -type d -name '*.egg-info' -exec rm -rf {} \;
	@find . -depth -type d -name '.cov' -exec rm -rf {} \;
	@find . -type f -name '.coverage' -exec rm {} \;
	@find . -type f -name '*~' -exec rm {} \;
	@find . -type f -name '#*#' -exec rm {} \;
	@rm -f *.log


# ----------------------------------------------------------------------------------------
# eof
