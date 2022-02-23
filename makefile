VERSION = $(shell grep "version" pyproject.toml | sed 's/.*\"\(.*\)\"$$/\1/')
APP = deploy_ci/app
MANAGER = poetry run

IMAGE = deploy_ci
DOCKERFILE = 'docker/Dockerfile'

#-------------------------------------------------------------------------------


run: ## executa projeto
	@FLASK_ENV=development \
	FLASK_APP=${APP} \
	${MANAGER} flask run --host 0.0.0.0 --port 5000

test: ## roda testes
	@${MANAGER} pytest -vv .

test_xml: ## roda testes e criar relatorio xml
	@${MANAGER} pytest -vv --cov=. --cov-report=xml

requirements: ## atualiza arquivo requirements.txt
	poetry export > requirements.txt

image: #requirements ## constroi imagem docker
	echo '...building image'
	docker build --rm -f ${DOCKERFILE} -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest .

.PHONY:run test test_xml build_image


#-------------------------------------------------------------------------------


lint: lint_black lint_flake8 lint_isort lint_mypy ## excecuta analise completa
	@echo -e '\nAnalise completa finalizada com sucesso!\n'

lint_black: ## analisa sintaxe
	@echo -e '\n...Analisando sintaxe'
	@${MANAGER} black --skip-string-normalization --diff --check .

lint_flake8: ## analisa estilo
	@echo -e '\n...Analisando estilo'
	@${MANAGER} flake8 --ignore=W583,E501 .

lint_isort: ## analisa importacoes
	@echo -e '\n...Analisando importacoes'
	@${MANAGER} isort --profile=black --lines-after-import=2 --check --diff .

lint_mypy: ## analisa tipos
	@echo -e '\n...Analisando tipos'
	@${MANAGER} mypy .

.PHONY: lint lint_black lint_flake8 lint_isort lint_mypy


#-------------------------------------------------------------------------------

clean: ## exclui arquivos temporarios
	@echo '...excluindo arquivos temporarios'

help: ## exibe mensagem de ajuda
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | \
	sed -e 's/:.*##\s*/:/' \
	-e 's/^\(.\+\):\(.*\)/\\x1b[36mmake \1\\x1b[m:\2/' | \
	column -c2 -t -s :']]')"

.PHONY: clean help
