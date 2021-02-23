FROM pytorch/pytorch:latest
RUN set -x \
    && apt-get -qq update \
    && apt-get -y -qq upgrade \
    && apt-get install -y -qq --no-install-recommends libsm6 libxext6 libxrender-dev ffmpeg \
    && rm -rf /var/lib/apt/lists/* \
    && /opt/conda/bin/conda install -q -y nodejs opencv Cython tensorflow pandas scikit-learn matplotlib seaborn jupyter jupyterlab \
    && /opt/conda/bin/conda install -q -c conda-forge tensorboardx \
    && /opt/conda/bin/conda clean -ya \
    && pip install -q jupyter_tensorboard torchvision scikit-image torchtext keras
RUN set -x\
    && jupyter labextension install jupyterlab_tensorboard \
    && pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U; exit 0\
    && mkdir -p /home/me && chmod 1777 /home/me
ENV HOME /home/me
# tensorboard
EXPOSE 6006
# jupyter notebook
EXPOSE 8888
CMD jupyter tensorboard enable --user&&jupyter lab --no-browser --ip=0.0.0.0 --port=8888 --allow-root
