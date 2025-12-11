COMPOSE = srcs/docker-compose.yml

DC = docker compose -f $(COMPOSE)

LOGIN = chakim
DATA_PATH = /home/$(LOGIN)/data

all: init_host
		$(DC) up --build -d

init_host:
	@mkdir -p $(DATA_PATH)/db
	@mkdir -p $(DATA_PATH)/wp

build:
	$(DC) build

down:
	$(DC) down

clean:
	$(DC) down -v

log:
	$(DC) logs -f

re: clean all

.PHONY: all build down clean re init_host log
