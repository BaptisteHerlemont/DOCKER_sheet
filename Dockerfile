FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Install system packages + Python + R
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    git \
    vim \
    python3 \
    python3-pip \
    r-base \
    r-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --no-cache-dir --break-system-packages \
    numpy \
    pandas \
    matplotlib \
    scikit-learn \
    requests

# Install R packages
RUN R -e "install.packages(c('dplyr','ggplot2','data.table'), repos='https://cloud.r-project.org')"

# Create a custom bash script
RUN printf '#!/bin/bash\n\
echo "Hello from container"\n\
python3 --version\n\
R --version\n' > /usr/local/bin/hello.sh \
    && chmod +x /usr/local/bin/hello.sh

CMD ["bash"]
