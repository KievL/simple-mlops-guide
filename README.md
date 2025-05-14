# Simple MLOps Guide

This guide provides a step-by-step walkthrough to set up a basic MLOps environment using virtual machines, Docker, and a simple ML model deployment.

By the end of this guide, you will understand:
- What a Virtual Machine (VM) is and its role in infrastructure and deployment.
- What Docker is and how it simplifies packaging and running applications.
- How to build a simple web server application using Docker.
- How to package and deploy a machine learning model with Docker.

## 1. What is a Virtual Machine (VM) and what is it used for?

A Virtual Machine (VM) is an isolated computing environment that runs on top of a physical machine using a hypervisor (such as VirtualBox, VMware, or Hyper-V).

In cloud environments (like AWS, Azure, Google Cloud), virtual machines (VMs) are the basic building blocks of infrastructure. When you create a cloud server (e.g., an EC2 instance on AWS), you're actually launching a VM.

These VMs simulate an independent computer with:

- Its own operating system (e.g., Ubuntu, CentOS)
- Allocated resources (CPU, RAM, storage)
- Root access and full control

This makes VMs ideal for:

- Hosting web servers and databases
- Running scripts or automation
- Running isolated development environments
- Hosting containers like Docker

### Acessing VMs with SSH

When working with VMs, especially in the cloud, you usually access them remotely through a secure terminal connection using SSH (Secure Shell).

### What is SSH?

SSH (Secure Shell) is a protocol that allows secure, encrypted communication between your local machine and a remote server (such as a VM). It’s the standard way to manage and configure remote Linux-based VMs.

### Example: Connecting via SSH
```bash
ssh <username>@<host> -P <port>
```
Then you may be asked to enter the user password.

## 2. What is Docker and what is it used for?

Docker is a platform that allows you to package applications and their dependencies into containers, which are lightweight, portable, and isolated environments that run directly on your host system.

This means you can:

- Run your application anywhere (locally, in the cloud, on another server).
- Avoid the “it works on my machine” problem.
- Deploy with confidence, knowing the environment is consistent.

### Docker images

A Docker image is like a blueprint or a snapshot of a complete application environment. It includes:

- The operating system layer (e.g., Debian, Alpine, Ubuntu).
- Dependencies (like Python, libraries, packages).
- Source code for your application.
- Configuration scripts (e.g., Dockerfile, requirements.txt).

You build an image once and then use it to create containers.

### Docker container

A running instance of an image. It’s like an object of a class. You can start, stop, and destroy it without affecting the image.

## 3. Creating a Simple Web Server with Docker

Let’s build a basic web server using Flask (a lightweight Python web framework) and run it inside a Docker container.

### Acess the VM using SSH:
```bash
ssh <username>@<host> -P <port>
```

Enter you password and you're in.

### Install docker

Install Docker following [Docker Installation](https://docs.docker.com/engine/install/ubuntu/) if your VM does not have Docker installed yet.

### Open the Web Server project

Clone this repository in your VM using git:

```bash
git clone https://github.com/KievL/simple-mlops-guide.git
```

### Build the web server image

`webserver.py` is a web server made with Flask. In order to build its image, run:
```bash
docker build -t webserver -f webserver.Dockerfile .
```

### Run the container

In order to run the built image on a container, run:
```bash
docker run -p 5000:5000 webserver
```

The web server is now running. Check on your browser: `0.0.0.0:5000`.

### Stop the container

```bash
docker stop <container-id>
```

## Deploying a Machine Learning Model with Docker

### Train and Save the Model (model_webserver.py):

Run the `model_webserver.py` in order to generate the `model.pkl`.

### Build the model API image

```bash
docker build -t model_webserver -f model_webserver.Dockerfile .
```

### Run the model container

```bash
docker run -p 5000:5000 model_webserver
```

### Test the model via CURL

```bash
curl -X POST http://<host>:5000/predict \
     -H "Content-Type: application/json" \
     -d '{"features": [5.1, 3.5, 1.4, 0.2]}'
```

The response must be something like:
`{"prediction":0}`

## Run the containers using docker compose

You can configure containers to run using `docker-compose.yml` configuration file.

Checking the file, you can see that we defined two services called **webserver** and **model**.

In order to run these two at the same time, use _docker compose_ command:

```bash
docker compose up -d
```

The result will be the same as the previous step.

Note that **model** service is now running on port 5001 since two services cannot serve on the same port.

To stop the containers, run:
```bash
docker compose stop
```

To deleted them:

```bash
docker compose down
```
