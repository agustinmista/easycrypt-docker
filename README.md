# easycrypt-docker

A Docker image with EasyCrypt, Z3, Alt-Ergo, and Emacs with Proof-General and evil-mode preinstalled :D

## Usage

To run the image directly:

```
$ docker run --rm -it -v $PWD:/home/easycrypt/workdir agustinmista/easycrypt
```

Please note that this binds your current $PWD into the container, so you can edit files from your host by passing them as arguments to the container.

### Creating an alias

For convenience, you might want to create an alias:

```
$ alias easycrypt='docker run --rm -it -v $PWD:/home/easycrypt/workdir agustinmista/easycrypt'
```

So editing files simply becomes:

```
$ easycrypt my-file.ec
```

## Building

To build this image locally, it should be enough to clone this repository and call `./build`.

```
$ git clone https://github.com/agustinmista/easycrypt-docker
$ cd easycrypt-docker
$ ./build
```