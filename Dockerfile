FROM rocker/binder:4.1.3

# Copy repo into ${HOME}, make user own $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

## run any install.R script we find
RUN if [ -f install.R ]; then R --quiet -f install.R; fi
RUN Rscript -e 'BiocManager::install("EBImage")'
RUN Rscript -e 'devtools::install_github("OpenDroneMap/FIELDimageR", dependencies=FALSE)'
