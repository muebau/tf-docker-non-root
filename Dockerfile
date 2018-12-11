FROM tensorflow/tensorflow:latest-gpu

RUN chmod 777 /notebooks

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh", "--ip=127.0.0.1" "--port 8888"]
