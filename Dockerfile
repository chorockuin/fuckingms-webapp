# Use the latest Ubuntu image
FROM ubuntu:24.04

# Set the environment variables
ENV PYTHON_VERSION=3.12

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
    python3.12-venv

# Install Python 3.12
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-venv

# Update alternatives to use python3.12 and pip3.12
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip${PYTHON_VERSION} 1

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Activate virtual environment and install Streamlit
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install streamlit

# Set the virtual environment as the default python and pip
ENV PATH="/opt/venv/bin:$PATH"

# Set the working directory
WORKDIR /app

# Command to run Streamlit
CMD ["streamlit", "run"]
