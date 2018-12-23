FROM tensorflow/tensorflow:latest-gpu

RUN chmod 777 /notebooks

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV R_LIBS_USER="~/.local/R_libs/"

RUN apt-get install -y gnupg2
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/'
RUN apt-get update

RUN apt-get install -y r-base
RUN apt-get install -y libssl-dev
RUN apt-get install -y libgit2-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y python3-dev
RUN apt-get install -y python-dev
RUN apt-get install -y git
RUN apt-get install -y build-essential
RUN apt-get install -y socat
RUN apt-get install -y netcat
RUN apt-get install -y vim
RUN apt-get install -y libpng-dev
RUN apt-get install -y libzmq3-dev
RUN apt-get install -y pkg-config
RUN apt-get install -y python
RUN apt-get install -y python-dev
RUN apt-get install -y rsync
RUN apt-get install -y software-properties-common
RUN apt-get install -y unzip

RUN apt-get clean && \
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
