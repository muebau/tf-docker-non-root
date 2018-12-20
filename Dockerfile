FROM tensorflow/tensorflow:latest-gpu

RUN chmod 777 /notebooks

RUN apt-get update && apt-get install -y --no-install-recommends \
        r-base \
        libssl-dev \
        libgit2-dev \
        libcurl4-openssl-dev \
        socat \
        netcat \
        vim \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    python3 -m pip install Pillow \
        h5py \
        ipykernel \
        jupyter \
        keras_applications \
        keras_preprocessing \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        && \
    python3 -m pip install ipykernel && \
    python3 -m ipykernel install --user && \
    python3 -m ipykernel.kernelspec

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/notebooks --ip 0.0.0.0 --no-browser --port 8888"]
