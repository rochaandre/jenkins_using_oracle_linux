# Jenkins in Docker Deployment

This repository provides a streamlined approach to deploying Jenkins, the popular open-source automation server, within a Docker container.  This method simplifies Jenkins setup, management, and ensures consistent execution across different environments.  This README focuses specifically on the repository's GitHub-related information, including commit history, forks, and other relevant details.  For deployment and usage instructions, please see [DEPLOYMENT.md](DEPLOYMENT.md).

This is a docker jenkins deploy using oracle linux

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/rochaandre/jenkins)](https://github.com/rochaandre/jenkins/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/rochaandre/jenkins)](https://github.com/rochaandre/jenkins/network/members)
[![GitHub Issues](https://img.shields.io/github/issues/rochaandre/jenkins)](https://img.shields.io/github/issues/rochaandre/jenkins/issues)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/rochaandre/jenkins)](https://github.com/rochaandre/jenkins/commits/main)

## Table of Contents


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

This repository simplifies the process of deploying Jenkins using Docker.  While the primary goal is easy Jenkins deployment, this README specifically documents information about the repository itself, its commit history, how to contribute, and other GitHub-related aspects.  For instructions on *using* the Docker image, please refer to the [deployment guide](DEPLOYMENT.md).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

This project utilizes the following technologies:

*   **Python:** [![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)
*   **Docker:** [![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
*   **YAML:** [![YAML](https://img.shields.io/badge/YAML-CB8112?logo=yaml&logoColor=white)](https://yaml.org/)
*   **Text Files (.txt):**   "Configuration files (.txt)"


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

This section provides instructions on how to set up and run the project using Docker.

### Prerequisites

Before you begin, ensure you have the following installed on your Linux system:

*   **Docker:**  Follow the official Docker installation guide for Linux: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
    *   Specifically, choose the distribution of Linux you're using.
*   **(Optional) Docker Compose:** Docker Compose is recommended for managing multi-container applications. Install it if your project uses it: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

    *   For most Linux distributions, you can download the Docker Compose binary directly. For example:
        ```bash
        sudo curl -L "[https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname](https://www.google.com/search?q=https://github.com/docker/compose/releases/latest/download/docker-compose-%24(uname) -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        ```

### Installation

1.  **Follow all steps:**

    ```bash

    # this script remove all container and images - USE ONLY in a LAB SYSTEM.
    docker container rm -f $(docker container ls -qa)
    docker image rm -f $(docker image ls -q)

    mkdir /docker/jenkins -p
    cd /docker/jenkins
    # create/copy template for Dockerfile use the file from this github
    vi Dockerfile

    # login Oracle registry - I used oracle linux - create the user www.oracle.com - register
    docker login container-registry.oracle.com -u user@example.com -p passforthisuser

    # build the image locally
    docker build -t jenkins_oracle_linux -f Dockerfile .

    # Run the image as container
    docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure --name jenkins_oracle_linux jenkins_oracle_linux 

    # Execute the command inside of a running container
    docker exec --user jenkins -it jenkins_oracle_linux /bin/bash 

    ```

2.  **The output will be similar:** 

    ```bash
    [root@srvfedoranfs jenkins]#docker images
    REPOSITORY             TAG       IMAGE ID       CREATED         SIZE
    jenkins_oracle_linux   latest    ebb85e71f177   9 minutes ago   1.92GB

    [root@srvfedoranfs jenkins]#docker ps 
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


    [root@srvfedoranfs jenkins]#docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure --name jenkins_oracle_linux jenkins_oracle_linux
    7653441da6087b3516b2a4686d791416a52819411c126146b664330c2051ae05


    [root@srvfedoranfs jenkins]#docker ps 
    CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                                              NAMES
    7653441da608   jenkins_oracle_linux   "/usr/bin/jenkins --…"   8 seconds ago   Up 7 seconds   0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp   jenkins_oracle_linux

    [root@srvfedoranfs jenkins]#docker exec --user jenkins -it jenkins_oracle_linux /bin/bash 
    bash-4.4$ 
    bash-4.4$ id
    uid=998(jenkins) gid=995(jenkins) groups=995(jenkins)
    bash-4.4$ pwd
    /jenkins
    bash-4.4$ exit
    exit
    [root@srvfedoranfs jenkins]#
    ```

## Usage

This section explains how to create and run your application using Docker.

### Login Docker Oracle Registry
  ```bash
docker login container-registry.oracle.com -u username@example.com -p passwordforthisusername
```
### Docker Container Creation

There are two main ways to create and run the Docker container: using a `Dockerfile` directly or using a `docker-compose.yml` file.

#### Using Dockerfile

1.  **Build the Image:**

    ```bash
    docker build -t your-image-name .  # The '.' indicates the Dockerfile is in the current directory

    # this script remove all container and images - USE ONLY in a LAB SYSTEM.
    docker container rm -f $(docker container ls -qa)
    docker image rm -f $(docker image ls -q)

    mkdir /docker/jenkins -p
    cd /docker/jenkins
    # create/copy template for Dockerfile use the file from this github
    vi Dockerfile

    # build the image locally
    docker build -t jenkins_oracle_linux -f Dockerfile .
    
    ```
 

2.  **Run the Container:**

    ```bash
    docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure --name jenkins_oracle_linux jenkins_oracle_linux 
    ```

    *   `-p 8080:8080`: Maps port 8080 on the host to port 8080 in the container (change if your application uses a different port).
    *   `-v data:/app/data`: Mounts a volume. This maps the `data` directory on your host to `/app/data` inside the container.
    *   This is crucial for data persistence.  If your application doesn't need persistent storage, you can omit the `-v` flag.
  

    **This will use current path for jenkins work_dir** 

    ```bash
      docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure -v /docker/jenkins:/jenkins --name jenkins jenk 
    ```

3.  **Check process inside of a running container:**

    ```bash
    docker exec --user jenkins -it jenkins_oracle_linux /bin/bash 
    ```



#### Using Docker Compose

1.  **Create `docker-compose.yml`:**  A `docker-compose.yml` file defines your application's services (containers).  Here's an example:

    ```yaml
    version: "3.9"  # Or your preferred version
    services:
      web:
        build: . # Build the image using the Dockerfile in the current directory
        ports:
          - "8080:8080"
        volumes:
          - data:/app/data
        # Add any other configurations like environment variables, depends_on, etc.
    volumes:
      data: # Named volume for data persistence
    ```

2.  **Run with Docker Compose:**

    ```bash
    docker-compose up -d  # '-d' runs the container in detached mode (background)
    ```

    To stop the containers:

    ```bash
    docker-compose down
    ```



<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Repository Structure

- [Introduction](#introduction)
- [Repository Structure](#repository-structure)
- [Commit History](#commit-history)
- [Forking and Contributing](#forking-and-contributing)
- [Issues and Bug Reports](#issues-and-bug-reports)
- [GitHub Actions (Optional)](#github-actions-optional)
- [License](#license)
