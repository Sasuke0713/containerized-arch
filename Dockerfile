FROM ubuntu:22.04

# LABEL about the custom image
LABEL maintainer="Service_Team"

# Set environment variable to suppress debconf warnings
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    python2 \
    python3 \
    r-base \
    python3-pip \
    curl \
    && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
    && python2 get-pip.py \
    && rm get-pip.py \
    && apt-get install -y python3-pip

# Install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip2 install -r /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Keep the container running
CMD ["tail", "-f", "/dev/null"]