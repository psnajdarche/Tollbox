# Use a base image with Python pre-installed
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive \
    USER=pavle \
    HOME=/home/$USER \
    PATH=/home/$USER/bin:$PATH

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        unzip \
    && rm -rf /var/lib/apt/lists/*
   

# Install Ansible
RUN pip install ansible

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl
# Install tera
RUN curl -LO https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip \
    && unzip terraform_0.15.4_linux_amd64.zip \
    && mv terraform $HOME/bin \
    && rm terraform_0.15.4_linux_amd64.zip
# Create a non-root user
RUN useradd -ms /bin/bash $USER

# Set the working directory and ownership
WORKDIR /app
RUN chown -R $USER:$USER /app

# Switch to the non-root user
USER $USER

#
CMD ["/bin/bash"]
