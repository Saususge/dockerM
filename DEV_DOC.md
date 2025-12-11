This document explains the technical details for developers who want to modify or maintain the project.

## Environment Setup
The project structure is as follows:
```text
.
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

Here are the three documentation files (README.md, USER_DOC.md, and DEV_DOC.md) tailored to your specific configuration and strictly following the requirements in the Inception.pdf.

1. README.md
This file fulfills the requirements from Chapter VI (Page 13).

Markdown

*This project has been created as part of the 42 curriculum by chakim.*

# Inception

## Description
This project represents a System Administration exercise designed to broaden knowledge of system administration using Docker. The goal is to virtualize several Docker images to create a personal virtual machine infrastructure.

The project sets up a small infrastructure composed of different services under specific rules, ensuring strict isolation and performance. The stack includes NGINX, WordPress, MariaDB, and various bonus services, all orchestrated via Docker Compose on Alpine Linux.

## Instructions
To deploy this infrastructure, you must have `docker`, `docker compose`, and `make` installed on your machine.

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd inception
Setup Host: Ensure the domain chakim.42.fr points to your local IP (127.0.0.1) in your /etc/hosts file.

Launch the project: Run the following command at the root of the directory:

Bash

make
This will create the necessary data directories, build the Docker images, and start the containers.

Stop the project:

Bash

make down
Clean up: To remove all containers, networks, volumes, and images:

Bash

make fclean
Project Description & Design Choices
This project uses Docker to containerize services, ensuring consistency across different environments.

OS: All containers are built from Alpine Linux 3.21.5 for minimizing image size and security attack surfaces.

Orchestration: docker-compose is used to manage the multi-container application.

Security: TLSv1.2/1.3 is enforced on NGINX (port 443). No passwords are stored in Dockerfiles; they are managed via Docker Secrets and Environment Variables.

Comparisons
Virtual Machines vs Docker
Virtual Machines (VMs): Emulate a complete hardware system (Guest OS) running on a Hypervisor. They are heavy, resource-intensive, and slow to boot.

Docker: Uses OS-level virtualization. Containers share the Host OS kernel but run in isolated userspaces. They are lightweight, fast to start, and portable.

Secrets vs Environment Variables
Environment Variables: Useful for non-sensitive configuration (e.g., domain names). However, they can be inspected via docker inspect, making them insecure for passwords.

Secrets: Securely manage sensitive data (passwords, keys). In this project, secrets are stored in files and mounted into /run/secrets/ inside the container, preventing them from being exposed in environment logs.

Docker Network vs Host Network
Host Network: The container shares the host's networking namespace. It offers high performance but lacks isolation (port conflicts can occur).

Docker Network (Bridge): Creates an isolated software bridge. Containers communicate via internal IP addresses/DNS names (e.g., wordpress or mariadb) without exposing internal ports to the outside world unless explicitly mapped.

Docker Volumes vs Bind Mounts
Docker Volumes: Managed by Docker (stored in /var/lib/docker/volumes). easier to back up and migrate but harder to access directly from the host.

Bind Mounts: Maps a specific file or directory on the host to the container. In this project, we use Bind Mounts (/home/chakim/data/) to ensure data persists exactly where the subject requires it on the host machine.

Resources
Docker Documentation

Alpine Linux Packages

NGINX Documentation

AI Usage
AI tools were used to:

Clarify specific configuration syntax for vsftpd and glances.

Debug complex NGINX location blocks for the Adminer and monitoring redirections.


---

### 2. USER_DOC.md

This file fulfills the requirements from **Chapter VII** (Page 14) for **User Documentation**.

```markdown
# User Documentation

This guide explains how to interact with the Inception infrastructure as an end-user or administrator.

## Services Provided
The stack provides the following services:
* **WordPress:** A blogging platform.
* **MariaDB:** The database backend.
* **NGINX:** The secure web server and reverse proxy.
* **Redis:** A cache system to improve WordPress performance.
* **Adminer:** A database management interface.
* **FTP Server:** For transferring files to the WordPress volume.
* **Static Site:** A bonus HTML website ("Blog").
* **Monitoring:** Real-time system monitoring via Glances.

## Starting and Stopping
* **Start:** Run `make` in the terminal. Wait for the build to finish.
* **Stop:** Run `make down` to stop containers.
* **Restart/Rebuild:** Run `make re` to fully rebuild and restart.

## Accessing Services
All web services are accessible via the secure domain **https://chakim.42.fr**. Accept the self-signed certificate warning in your browser.

| Service | URL | Description |
| :--- | :--- | :--- |
| **WordPress** | `https://chakim.42.fr/` | Main website. |
| **Adminer** | `https://chakim.42.fr/adminer.php` | Database management. Login with DB credentials. |
| **Static Site** | `https://chakim.42.fr/blog/` | A simple bonus HTML page. |
| **Monitoring** | `https://chakim.42.fr/monitor/` | Glances system monitor. |

## Managing Credentials
Credentials are **not** hardcoded in the application. They are stored in local files within the `secrets/` directory on the host machine.
* **Database Passwords:** `secrets/db_password.txt`, `secrets/db_root_password.txt`
* **WordPress Admins:** `secrets/wp_admin_pass.txt`
* **FTP User:** `secrets/ftp_pass.txt`

To change a password, edit the corresponding text file in `secrets/` and restart the containers using `make re`.

## Checking Service Status
To verify that services are running correctly:
1.  Run `docker ps` to see the list of active containers. You should see: `nginx`, `wordpress`, `mariadb`, `redis`, `ftp`, `adminer`, `blog`, and `monitoring`.
2.  Check the logs of a specific service if it's behaving oddly:
    ```bash
    docker logs -f <container_name>
    # Example: docker logs -f wordpress
    ```
3. DEV_DOC.md
This file fulfills the requirements from Chapter VII (Page 14) for Developer Documentation.

Markdown

# Developer Documentation

This document explains the technical details for developers who want to modify or maintain the project.

## Environment Setup
The project structure is as follows:
```text
.
├── Makefile
├── dockerM
│   ├── secrets/          # Contains sensitive passwords
│   └── srcs/
│       ├── .env          # Environment variables (Domain, DB names)
│       ├── docker-compose.yml
│       └── requirements/ # Dockerfiles and config per service
Prerequisites
Host Machine: Linux (or VM) with Docker Engine and Docker Compose Plugin installed.

Secrets: Ensure the secrets/ folder exists and contains the required .txt files (e.g., db_password.txt).

Environment: The srcs/.env file defines variables like DOMAIN_NAME and MYSQL_DATABASE.

Build and Launch
The Makefile automates the docker compose commands.

Build: make build triggers docker compose build. This reads the Dockerfile in each requirements/<service> folder.

Up: make (or make up) runs docker compose up -d.

Verification: The Makefile creates the host data directories (/home/chakim/data/wp and /home/chakim/data/db) automatically via the init_host rule.

Managing Containers and Volumes
Dockerfiles
Each service has its own directory in srcs/requirements/.

Custom Configs: Configuration files (e.g., nginx.conf, www.conf, my.cnf) are copied from the conf/ subfolder into the container during the build.

Entrypoint Scripts: Scripts like wp.sh or db.sh in the tools/ subfolder handle runtime initialization (e.g., installing WordPress if it's missing).

Data Persistence
Data is persisted using Bind Mounts defined in docker-compose.yml:

Database: Maps host /home/chakim/data/db → container /var/lib/mysql.

WordPress Files: Maps host /home/chakim/data/wp → container /var/www/html.

This ensures that even if containers are destroyed (make down), the data remains on the host.

Network
All containers are attached to the inception bridge network. They resolve each other by service name (e.g., WordPress connects to mariadb:3306 and redis:6379).

### Development Workflow
- Modify Code: Edit files in srcs/requirements/.
- Rebuild: Run make re to force a rebuild of the images with your changes.
- Debug:
	- Shell into a container: docker exec -it <container_name> /bin/sh
	- Check specific logs: docker compose -f srcs/docker-compose.yml logs <service>