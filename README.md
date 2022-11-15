# easycrypt-docker

A Docker image with EasyCrypt, Z3, Alt-Ergo, and Doom Emacs with Proof-General
preinstalled :D

## Usage

To run the latest image directly from DockerHub:

```
$ docker run --rm -it -v ${PWD}:/home/easycrypt/workdir agustinmista/easycrypt
```

Which should open Emacs in terminal mode. Note that this also binds your current
$PWD into the container, so you can edit files from your host by passing them as
arguments to the container.

If you clone this repository, you can also run it with:

```
$ ./command.sh
```

Which will start a shell in the working directory. Note that `command.sh` leaves
the container running after use and doesn't delete it, meaning you can e.g. edit
the Doom config and keep it around. Just make sure to stop the container after
use!

If you want to customize doom before installing, you can change the configs
in `doom-config/`.

### Creating an alias

For convenience, you might want to create an alias:

#### Linux

```
$ alias easycrypt='docker run --rm -it -v $PWD:/home/easycrypt/workdir agustinmista/easycrypt'
```

#### Windows (PowerShell)

```
PS C:\> function Docker-Run-EasyCrypt { docker run --rm -it -v ${PWD}:/home/easycrypt/workdir agustinmista/easycrypt $args }
PS C:\> Set-Alias -Name easycrypt -Value Docker-Run-EasyCrypt
```

So editing files simply becomes:

```
$ easycrypt my-file.ec
```

## Building

To build this image locally, it should be enough to clone this repository and
call `./build`.

```
$ git clone https://github.com/agustinmista/easycrypt-docker
$ cd easycrypt-docker
$ ./build
```
