*This project has been created as part of the 42 curriculum by chakim.*

# Inception

## Description
This project represents a System Administration exercise designed to broaden knowledge of system administration using Docker. The goal is to virtualize several Docker images to create a personal virtual machine infrastructure.

The project sets up a small infrastructure composed of different services under specific rules, ensuring strict isolation and performance. The stack includes NGINX, WordPress, MariaDB, and various bonus services, all orchestrated via Docker Compose on Alpine Linux.

## Instructions
To deploy this infrastructure, you must have `docker`, `docker compose`, and `make` installed on your machine.

1. **Clone the repository:**
- clone repo from 42 site

2. **Setup Host**
- Set the domain chakim.42.fr points to your local IP (127.0.0.1) in your /etc/hosts file.

3. **Build with make**
- Run ``make`` command at the root directory of the project.
- This will create the necessary data directories, build the Docker images, and start the containers.

4. **How to stop or clean**
- Stop for ``make down``
- clean up for ``make clean``

## Project Description
- This project uses Docker to containerize services, ensuring consistency across different environments.

- OS: All containers are built from Alpine Linux 3.21.5 for minimizing image size and security attack surfaces.

- Orchestration: docker-compose is used to manage the multi-container application.

- Security: TLSv1.2/1.3 is enforced on NGINX through 443(https). No passwords are stored in Dockerfiles. Those are managed via Docker secrets and environment variables.

## Comparisons
##### Virtual Machines vs Docker
- Virtual Machines (VMs): Emulate a complete hardware system (Guest OS) running on a Hypervisor. They are heavy, resource-intensive, and slow to boot.

- Docker: Uses OS-level virtualization. Containers share the Host OS kernel but run in isolated userspaces. They are lightweight, fast to start, and portable.

##### Secrets vs Environment Variables
- Environment Variables: Useful for non-sensitive configuration (e.g., domain names). However, they can be inspected via docker inspect, making them insecure for passwords.

- Secrets: Securely manage sensitive data (passwords, keys). In this project, secrets are stored in files and mounted into /run/secrets/ inside the container, preventing them from being exposed in environment logs.

##### Docker Network vs Host Network
- Host Network: The container shares the host's networking namespace. It offers high performance but lacks isolation (port conflicts can occur).

- Docker Network (Bridge): Creates an isolated software bridge. Containers communicate via internal IP addresses/DNS names (e.g., wordpress or mariadb) without exposing internal ports to the outside world unless explicitly mapped.

##### Docker Volumes vs Bind Mounts
- Docker Volumes: Managed by Docker (stored in /var/lib/docker/volumes). easier to back up and migrate but harder to access directly from the host.

-Bind Mounts: Maps a specific file or directory on the host to the container. In this project, we use Bind Mounts (/home/chakim/data/) to ensure data persists exactly where the subject requires it on the host machine.

## Resources
- https://docs.docker.com/
- https://pkgs.alpinelinux.org/packages
- https://nginx.org/en/docs/
- https://www.cloudflare.com/ko-kr/learning/ssl/what-is-ssl/

##### AI Usage
- AI tools were used to clarify specific configuration syntax for vsftpd and glances.
- Making a test script for FTP file transfer via host machine.
- Making md files structures.
- Fixing md documents like spell checking, etc...
- Reconstructing md files for making sheet, better visualize.