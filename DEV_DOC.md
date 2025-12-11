This document explains the technical details for developers who want to modify or maintain the project.

## Environment Setup
The project structure is as follows:
```text
├── Makefile
├── dockerM
│   ├── secrets/          # Contains sensitive passwords
│   └── srcs/
│       ├── .env          # Environment variables (Domain, DB names)
│       ├── docker-compose.yml
│       └── requirements/ # Dockerfiles and config per service
```

### Prerequisites
- Host Machine: Linux (or VM) with Docker Engine and Docker Compose Plugin installed.
- Secrets: Ensure the secrets/ folder exists and contains the required .txt files (e.g., db_password.txt).
- Environment: The srcs/.env file defines variables like DOMAIN_NAME and MYSQL_DATABASE.

### Build and Launch
The Makefile automates the docker compose commands.

- Build: make build triggers docker compose build. This reads the Dockerfile in each requirements/<service> folder.
- Up: make (or make up) runs docker compose up -d.
- Verification: The Makefile creates the host data directories (/home/chakim/data/wp and /home/chakim/data/db) automatically via the init_host rule.

### Managing Containers and Volumes
##### Dockerfiles
Each service has its own directory in srcs/requirements/.

- Custom Configs: Configuration files (e.g., nginx.conf, www.conf, my.cnf) are copied from the conf/ subfolder into the container during the build.
- Entrypoint Scripts: Scripts like wp.sh or db.sh in the tools/ subfolder handle runtime initialization (e.g., installing WordPress if it's missing).

##### Data Persistence
Data is persisted using Bind Mounts defined in docker-compose.yml:

- Database: Maps host /home/chakim/data/db to container /var/lib/mysql.
- WordPress Files: Maps host /home/chakim/data/wp to container /var/www/html.

This ensures that even if containers are destroyed (make down), the data remains on the host.

##### Network
All containers are attached to the inception bridge network. They resolve each other by service name.

### Development Workflow
- Modify Code: Edit files in srcs/requirements/.
- Rebuild: Run make re to force a rebuild of the images with your changes.
- Debug:
	- Shell into a container: docker exec -it <container_name> /bin/sh
	- Check specific logs: docker compose -f srcs/docker-compose.yml logs <service>