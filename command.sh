#!/usr/bin/env bash
docker run --name easycrypt -it --entrypoint "/usr/bin/bash" -v "$PWD:/home/easycrypt/workdir" agustinmista/easycrypt ||
  docker start easycrypt && docker exec -it easycrypt /usr/bin/bash
