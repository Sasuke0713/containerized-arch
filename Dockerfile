FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    python2 \
    python3 \
    r-base \
    python3-pip \
    python-pip

# Install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip2 install -r /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Keep the container running
CMD ["tail", "-f", "/dev/null"]