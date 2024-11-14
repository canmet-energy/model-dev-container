# Running the H2K_HPXML with Docker CLI in two steps.

## Requirements
### Docker

You will need admin rights or somebody who is an admin to install Docker.  

**Windows**: [Docker Desktop 2.0+](https://www.docker.com/products/docker-desktop/) on Windows 10 Pro/Enterprise. Windows 10 Home (2004+) requires Docker Desktop 2.3+ and the WSL 2 back-end. (Docker Toolbox is not supported. Windows container images are not supported.) Installation instructions are [here](https://docs.docker.com/desktop/install/windows-install/) ensure that your windows user account is part of the docker-group. **Do not skip that step**. 

**macOS**: [Docker Desktop 2.0+](https://www.docker.com/products/docker-desktop/).

**Linux**: Docker CE/EE 18.06+ and Docker Compose 1.21+. (The Ubuntu snap package is not supported.) Use your distros package manager to install.

Ensure that docker desktop is running on your system.  You should see it present in your windows task tray.  Then run the following command. 

Note: Right now we only support Docker Desktop, but Podman or Rancher could work as well.

```
docker run hello-world
```

You should see the following output.

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Pull complete
Digest: sha256:d000bc569937abbe195e20322a0bde6b2922d805332fd6d8a68b19f524b7d21d
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

To run the CLI using the `docker run` command, follow these steps:

1. **Place H2K file in a folder**
    Place your .h2k files into a folder. Ideally locally on your C: drive if you use windows. For this example we will use C:\test . 

1. **Run the Docker Container**:
    Use the `docker run` command to start a container and execute the CLI.
    ```sh
    docker run --rm -it -v //c/test:/shared canmet/model_dev_container:3.7.0 cli run
    ```
    Swtiches used:
    - `-v`: Mounts your local folder, in this case /c/test, to the shared folder in the container. 
    - `--rm`: Automatically remove the container when it exits.
    - `-it`: Run the container in interactive mode with a TTY.

1.  By default the output is in the same folder provided, unless redirected using the output switch. It will create an output folder based on the name of the original h2k filename. The folder will contain
 * **the hpxml file**: designated by the .xml extension, and all the conventional. 
 * **the energy plus files**: this includes the idf, and htm and msgpack files.  ***By default, it does not produce the sqlite files or the osm files, To enable this, add the --debug flag to the run command.***

 It will also create a file called 'processing_results.csv' which will show the files that succeeded or failed.


Full help is available by issuing the run command with a -h. For example.

```
PS F:\> docker run -v //c/test:/shared canmet/model_dev_container:3.7.0 cli run -h
Usage: h2k2hpxml.py run [OPTIONS]

  Convert and Simulate H2K file to OS/E+.

Options:
  -i, --input_path TEXT           h2k file or folder containing h2k files.
  -o, --output_path TEXT          Path to output hpxml files. By default it is
                                  the same as the input path with a folder
                                  named output created inside it.
  --timestep TEXT                 Request monthly output type (ALL, total,
                                  fuels, enduses, systemuses, emissions,
                                  emissionfuels, emissionenduses, hotwater,
                                  loads, componentloads, unmethours,
                                  temperatures, airflows, weather,
                                  resilience); can be called multiple times
  --daily TEXT                    Request daily output type (ALL, total,
                                  fuels, enduses, systemuses, emissions,
                                  emissionfuels, emissionenduses, hotwater,
                                  loads, componentloads, unmethours,
                                  temperatures, airflows, weather,
                                  resilience); can be called multiple times
  --hourly TEXT                   Request hourly output type (ALL, total,
                                  fuels, enduses, systemuses, emissions,
                                  emissionfuels, emissionenduses, hotwater,
                                  loads, componentloads, unmethours,
                                  temperatures, airflows, weather,
                                  resilience); can be called multiple times
  --monthly TEXT                  Request monthly output type (ALL, total,
                                  fuels, enduses, systemuses, emissions,
                                  emissionfuels, emissionenduses, hotwater,
                                  loads, componentloads, unmethours,
                                  temperatures, airflows, weather,
                                  resilience); can be called multiple times
  -l, --add-component-loads       Add component loads.
  -d, --debug                     Enable debug mode and all extra file
                                  outputs.
  -s, --skip-validation           Skip Schema/Schematron validation for faster
                                  performance
  -f, --output-format TEXT        Output format for the simulation
                                  resultsOutput file format type (csv, json,
                                  msgpack, csv_dview)
  --add-stochastic-schedules      Add detailed stochastic occupancy schedules
  --add-timeseries-output-variable TEXT
                                  Add timeseries output variable; can be
                                  called multiple times; can be called
                                  multiple times
  --do-not-sim                    Convert only, do not run simulation
  -h, --help                      Show this message and exit.
```
