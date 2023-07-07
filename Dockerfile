FROM ubuntu


RUN apt-get update && apt-get install -y --no-install-recommends \
python3.5 \
python3-pip \
python3-setuptools \
curl \
sudo \
nano \
unzip \
wget \
&& \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip
RUN 
RUN case "$( uname -m )" in \
    'x86_64') \
        pip3 install ansible && \
        wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip && \
        unzip terraform_1.0.7_linux_amd64.zip && \
        mv terraform /usr/local/bin/ && \
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
        ;; \
    'aarch64') \
        wget https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_arm64.zip && \
        unzip terraform_1.5.2_linux_arm64.zip && \
        mv terraform /usr/local/bin/ && \
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl" && \
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
        ;; \
    esac

RUN useradd -m -s /bin/bash pavle
USER pavle 

CMD ["/bin/bash"]
