# Docker 

---

# 1) Search and download an image

## Search for an image on Docker Hub

docker search ubuntu  
docker search python  
docker search rocker/rstudio  

## Download an image

docker pull ubuntu:24.04  
docker pull python:3.12  
docker pull rocker/r-ver:4.4.1  

## List local images

docker images  

---

# 2) Use an image

## Run an interactive container

docker run -it ubuntu:24.04 bash  
docker run -it python:3.12 bash  

## Run and automatically remove container

docker run --rm -it ubuntu:24.04 bash  

## Run a command

docker run --rm python:3.12 python --version  
docker run --rm ubuntu:24.04 ls /  

## Mount a local folder

docker run --rm -it -v $(pwd):/work ubuntu:24.04 bash  

## Name a container

docker run --name mon_conteneur -it ubuntu:24.04 bash  

## List containers

docker ps  
docker ps -a  

## Stop / remove container

docker stop mon_conteneur  
docker rm mon_conteneur  

---

# 3) Download an image from my DockerHub (nutui)

## Download a public image

docker pull nutui/mon-image:latest  

## Examples

docker pull nutui/projet-r:latest  
docker pull nutui/mon-api:v1  

## Run the image

docker run --rm -it nutui/mon-image:latest bash  

---

# 4) Publish an image to DockerHub (nutui)

## Login

docker login  

## Build local image

docker build -t mon-image:latest .  

## Tag for DockerHub

docker tag mon-image:latest nutui/mon-image:latest  

## Push image

docker push nutui/mon-image:latest  

## Versioning

docker tag mon-image:latest nutui/mon-image:v1  
docker push nutui/mon-image:v1  

---

# 5) Create a simple image

## Minimal Dockerfile

FROM ubuntu:24.04  

WORKDIR /app  

CMD ["bash"]  

## Build

docker build -t mon-image:latest .  

## Run

docker run --rm -it mon-image:latest  

---

# 6) Full Dockerfile (Ubuntu + Python + R + Bash)

FROM ubuntu:24.04  

ENV DEBIAN_FRONTEND=noninteractive  

WORKDIR /app  

# System packages  
RUN apt-get update && apt-get install -y \  
bash \  
curl \  
wget \  
git \  
vim \  
python3 \  
python3-pip \  
r-base \  
&& rm -rf /var/lib/apt/lists/*  

# Python packages  
RUN pip3 install --no-cache-dir \  
numpy \  
pandas \  
matplotlib \  
scikit-learn  

# R packages  
RUN R -e "install.packages(c('dplyr','ggplot2','data.table'), repos='https://cloud.r-project.org')"  

# Custom bash script  
RUN echo '#!/bin/bash\n\  
echo "Hello from container"' > /usr/local/bin/hello.sh \  
&& chmod +x /usr/local/bin/hello.sh  

CMD ["bash"]  

---

# 7) Dockerfile with requirements.txt

## Dockerfile

FROM python:3.12  

WORKDIR /app  

COPY requirements.txt .  

RUN pip install --no-cache-dir -r requirements.txt  

COPY . .  

CMD ["python", "app.py"]  

## requirements.txt

numpy  
pandas  
requests  
flask  

## Build + Run

docker build -t nutui/mon-app:latest .  

docker run --rm -it -p 5000:5000 nutui/mon-app:latest  

---
