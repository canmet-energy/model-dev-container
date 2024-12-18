REM Build Version 3.9.0
docker build --no-cache --build-arg OPENSTUDIO_VERSION=3.9.0 --build-arg OPENSTUDIO_HPXML_VERSION=1.9.1 --build-arg H2K_HPXML_VERSION=1.7.0.1.1 -t canmet/model_dev_container:3.9.0 .
docker push canmet/model_dev_container:3.9.0 
REM Build Version 3.8.0
docker build --no-cache --build-arg OPENSTUDIO_VERSION=3.8.0 --build-arg OPENSTUDIO_HPXML_VERSION=1.8.1 --build-arg H2K_HPXML_VERSION=1.7.0.1.1 -t canmet/model_dev_container:3.8.0 .
docker push canmet/model_dev_container:3.8.0 
REM Build Version 3.7.0
docker build --no-cache --build-arg OPENSTUDIO_VERSION=3.7.0 --build-arg OPENSTUDIO_HPXML_VERSION=1.7.0 --build-arg H2K_HPXML_VERSION=1.7.0.1.1 -t canmet/model_dev_container:3.7.0 .
docker push canmet/model_dev_container:3.7.0 

