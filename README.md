# Python development environment in Docker container

Allows you to put the folder `~/dev` inside the container ("/home/user/dev") and run the code using the desired version of Python.

## Step 0: Clone this repository

```shell
git clone https://github.com/svnikolaev/python-docker-envinonment.git
cd python-docker-envinonment
```

## Step 1: Setup `secrets_file`

Create `secrets_file` like `secrets_file.example` and set passwords for users `root` and `user`:

```text
root:password1
user:password2
```

## Step 2: Run environment with Docker Compose

### Python 3.11 environment

`PYTHON_VER=3.11 docker compose up -d --build`

### Python 3.10 environment

`PYTHON_VER=3.10 docker compose up -d --build`

### environment with http proxy

`PYTHON_VER=3.11 HTTP_PROXY=http://example.com:8080 docker compose up -d --build`

## Step 3: Connect to the container

`docker exec -it python_env bash`

## Step 4: Create virtual environment and install Python packages

```shell
cd /path/to/project/dirrectory
virtualenv --python="$(which python)" .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Step 5: Use Python

example:

```shell
(.venv) user@37b61e5ac0fb:~/dev/project$ python -m pytest
=============================== test session starts ===========================
platform linux -- Python 3.11.1, pytest-7.2.1, pluggy-1.0.0
rootdir: /home/user/dev/project
plugins: anyio-3.6.2
collected 2 items

tests/test_cases.py ..

================================ 2 passed in 0.84s ============================
```

## (Optional) Stop Docker Container

`docker compose down`

## (Optional) Build Docker image

You can also create a Docker image for later use.

### with Python 3.11

```shell
docker build --no-cache \
    --build-arg PYTHON_VER=3.11 \
    --secret id=SECRETS,src=secrets_file -t python_env:3.11 .
```

### with Python 3.10

```shell
docker build --no-cache \
    --build-arg PYTHON_VER=3.10 \
    --secret id=SECRETS,src=secrets_file -t python_env:3.10 .
```

### with http proxy

```shell
docker build --no-cache \
    --build-arg HTTP_PROXY=http://example.com:8080 \
    --build-arg HTTPS_PROXY=http://example.com:8080 \
    --build-arg PYTHON_VER=3.11 \
    --secret id=SECRETS,src=secrets_file -t python_env:3.11 .
```
