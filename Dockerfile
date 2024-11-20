# Base image compatible with the required OpenStudio version
ARG OPENSTUDIO_VERSION=3.9.0
FROM canmet/os_sdk_container:${OPENSTUDIO_VERSION} AS base

# Define versions for dependencies
ARG OPENSTUDIO_HPXML_VERSION=1.9.0
ARG H2K_HPXML_VERSION=1.7.0.1.1

# Install OpenStudio-HPXML to /OpenStudio-HPXML
RUN curl -k -L -o OpenStudio-HPXML-v${OPENSTUDIO_HPXML_VERSION}.zip https://github.com/NREL/OpenStudio-HPXML/releases/download/v${OPENSTUDIO_HPXML_VERSION}/OpenStudio-HPXML-v${OPENSTUDIO_HPXML_VERSION}.zip \
    && unzip OpenStudio-HPXML-v${OPENSTUDIO_HPXML_VERSION}.zip -d / \
    && rm OpenStudio-HPXML-v${OPENSTUDIO_HPXML_VERSION}.zip \
    && chmod -R 777 /OpenStudio-HPXML \
    && rm -rf /var/lib/apt/lists/* 

# Install H2K-HPXML and set up the prefix to use the /venv/bin/python always.
RUN curl -k -L -o H2K_HPXML_VERSION.zip https://github.com/canmet-energy/h2k_hpxml/archive/refs/heads/${H2K_HPXML_VERSION}.zip \
    && unzip H2K_HPXML_VERSION.zip -d /temp \
    && mv /temp/h2k_hpxml-${H2K_HPXML_VERSION} /h2k_hpxml \
    && rm H2K_HPXML_VERSION.zip \
    && chmod -R 777 /h2k_hpxml \
    && /venv/bin/pip install -r /h2k_hpxml/requirements.txt \
    && sed -i '1s/^/#!\/venv\/bin\/python\n/' /h2k_hpxml/bin/h2k2hpxml.py \
    && mkdir /shared \
    && chmod -R 777 /shared

# Create a CLI entry point
RUN echo '#!/bin/bash\n/h2k_hpxml/bin/h2k2hpxml.py "$@"' > /usr/bin/cli \
    && chmod +x /usr/bin/cli

# Set the virtual environment's Python as the default
ENV PATH=/venv/bin:$PATH

# Use the vscode user
USER vscode

# To run 
# docker build -t image_name .
# docker run -v //c/<path_to_your_h2k_files>:/shared image_name cli -h
