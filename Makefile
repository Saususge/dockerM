COMPOSE = srcs/docker-compose.yml

DC = docker compose -f $(COMPOSE)

all:
	$(DC) up --build -d

build:
	$(DC) build

down:
	$(DC) down

clean:
	$(DC) down -v

re: clean all

phony: all build down clean re