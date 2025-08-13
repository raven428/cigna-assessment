# Cigna Assessment

## 1. Local Execution

### Clone the Big4Health repository
I cloned provided repositories to private ones at GitHub:
- `https://github.com/raven428/big4health-admin`
- `https://github.com/raven428/big4health-frontend`
- `https://github.com/raven428/big4health-backend` with removed `big4health-backend` to reduce size

and `https://github.com/raven428/big4health-mongo` with directory `big-health-app` stored to `dump` folder used for MongoDB collection [restoration script](images/mongo/restore-dump.sh)

### Run the project in your local development environment

Done

### Take screenshots of running services and terminal logs

[admin](actions/runs/16929019246/job/47970281277#step:4:242), [frontend](actions/runs/16929019246/job/47970281275#step:4:242), [backend](actions/runs/16929019246/job/47970281281#step:4:240)

### Note any errors, missing dependencies, or difficulties

- `admin` and `frontend` repo required too outdated Node version 14 to build
- `nativeapp` repo too large, so skipped to save building time. I believe, other three repositories is enough for assesment

## 2. Containerization

### Write Dockerfiles for each subproject

[admin](images/admin/Dockerfile), [frontend](images/frontend/Dockerfile), [backend](images/backend/Dockerfile)

### Create a docker-compose.yml file to orchestrate all services

[compose.yaml](compose.yaml)

### Ensure .env variables are properly handled

Repositories `admin` and `frontend` doesn't read anything from environment, so there is no reason for variables

Environment variables for `backend` repository handled with `environment:` key, however `.env` file could [be used](compose.yaml#L31-L32)

## 3. Documentation

### Create a README.md that explains how to set up and run the containers

- `docker compose -f compose.yaml -p 'b4h' up -d` to run
- `docker compose -p 'b4h' down` to destroy

A container with MongoDB have already uploaded database from `backend` repo and changes will be written inside the container. To store database files outside a container [this part](compose.yaml#L83-L84) can be enabled

Container images are built and pushed by GitHub action from the [workflow](.github/workflows/build-n-push.yaml). This can be done by hand:

```
git clone https://github.com/raven428/big4health-${name}.git images/${name}/download
docker build -v $(pwd)/images/${name}/download:/download -t ghcr.io/raven428/container-images/big4health-${name}:latest images/${name}
```

where `${name}` should have `admin`, `frontend`, `backend`, and `mongo` values. Other code is simple and self-explanatory

### Include common troubleshooting tips based on your observations

As I mentioned above Node version 14 is too outdated and a lot of modules also should be updated as logged are outdated too at build logs

### Mention any architectural suggestions you believe would improve the system

`baseUrl` in `frontend` and `url`/`web` in `admin` repositories nice to have in environment

Orchestration of production system by docker compose is too heavy to maintain and should be done by some kind of Kubernetes on a few nodes with a clustered version of MongoDB to improve

This repo build with [GitOps](https://github.com/raven428/cigna-assessment/pulls?q=is%3Apr+is%3Aclosed) approach. Other repos should be done to with adding linters there. I usually prefer [MegaLinter](https://megalinter.io/). Also, I add a [couple](https://github.com/raven428/container-images/blob/master/sources/linters-ubuntu-22_04/files/check-syntax.sh) of my [linters](https://github.com/raven428/container-images/blob/master/_shared/install/ansible/check-syntax.sh) which applicable only for IaC code

## 4. Delivery

### Submit a link to your GitHub repo (private is okay)

Here we are

### Include all Docker-related files and the markdown documentation

Same here

### Optionally include a short screen recording of the successful container run

The frontend part is still running at HuggingFace container, so can be observed instead of a lot of screenshots: https://onionbag28-devops-frontend.hf.space
