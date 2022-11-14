# easycrypt-docker

A Docker image with EasyCrypt, Z3, Alt-Ergo, and Emacs with Proof-General and evil-mode preinstalled :D

## Usage

To run the image directly:

```
$ docker run --rm -it -v ${PWD}:/home/easycrypt/workdir agustinmista/easycrypt
```

Which should open Emacs in terminal mode. Note that this also binds your current $PWD into the container, so you can edit files from your host by passing them as arguments to the container.


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


### Disabling evil-mode 

If you don't like `evil-mode` (how dare you), you can turn it off by typing:

```
M-x evil-mode RET
```

Or by launching the container like so:

```
$ easycrypt --eval '(evil-mode 0)' my-file.ec
```

To make this change permanent, you can rebuild the image with your own `.emacs` file.


## Building

To build this image locally, it should be enough to clone this repository and call `./build`.

```
$ git clone https://github.com/agustinmista/easycrypt-docker
$ cd easycrypt-docker
$ ./build
```
