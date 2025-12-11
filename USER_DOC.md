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
```