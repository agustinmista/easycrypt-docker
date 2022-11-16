#!/usr/bin/env bash
docker run --name easycrypt -e DISPLAY -it --entrypoint "/usr/bin/bash" -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD:/home/easycrypt/workdir" agustinmista/easycrypt ||
 docker start easycrypt && docker exec -e DISPLAY -it easycrypt /usr/bin/bash
