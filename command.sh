#!/bin/bash

docker run --name easycrypt -it --entrypoint /bin/bash -v $PWD:/home/easycrypt/workdir agustinmista/easycrypt ||
  docker start easycrypt && docker exec -it easycrypt /bin/bash
