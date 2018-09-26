# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

FROM jupyter/all-spark-notebook:c7fb6660d096

LABEL maintainer="Greg Chevalley <github@stouffcapital.com>"

# Install Python 2 env
RUN conda create -p $CONDA_DIR/envs/python2 python=2.7 \
    'beautifulsoup4' \
    'bokeh' \
    'cloudpickle' \
    'cython' \
    'dill' \
    'h5py' \
    'hdf5' \
    'matplotlib' \
    'notebook' \
    'numba' \
    'pandas' \
    'patsy' \
    'pyzmq' \
    'requests' \
    'scipy' \
    'seaborn' \
    'scikit-learn' \
    'scikit-image' \
    'sqlalchemy' \
    'statsmodels' \
    'sympy' \
    'xlrd' \
    && conda clean -yt

USER root

# Install Python 2 kernel spec globally to avoid permission problems when NB_UID
# switching at runtime.
RUN $CONDA_DIR/envs/python2/bin/python \
    $CONDA_DIR/envs/python2/bin/ipython \
    kernel install



USER $NB_UID

# Install python 3 packages
RUN conda install --quiet --yes -c conda-forge \
      jupyter_contrib_nbextensions \
      neo4j-python-driver \
      python-dotenv && \
    conda install --quiet --yes \
     'gensim' \
     'keras' \
     'mysql-connector-python' \
     'nltk' \
     'psycopg2' \
     'scrapy' \
     'spacy' \
     'tensorflow' && \
    conda clean -tipsy && \
    jupyter contrib nbextension install --user && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
