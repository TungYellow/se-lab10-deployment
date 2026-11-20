# SE Lab 10 – Software Deployment (ASP.NET Core 8 + Docker)

* `MyAspNetCoreApp` – Razor Pages app with Docker support (Dockerfile, .dockerignore)
* `MyMvcApp` – MVC app with Docker support
* `docker-compose.yml` – runs both apps (ports 8080 and 8081)
* `.github/workflows/docker-image.yml` – GitHub Actions CI/CD (build + push to Docker Hub)
* `.gitlab-ci.yml` – GitLab CI/CD equivalent
* `cloud/deploy-azure.ps1`, `cloud/deploy-aws.sh` – Exercises 5 and 6

## Quick start
```
cd MyAspNetCoreApp
docker build -t myaspnetcoreapp .
docker run -d -p 8080:80 --name myaspnetcoreappcontainer myaspnetcoreapp
# open http://localhost:8080
```
GitHub Actions needs repository secrets `DOCKER_USERNAME` and `DOCKER_PASSWORD` (a Docker Hub access token).
