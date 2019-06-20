# Dotfiles

Each application's dotfiles are kept in a folder of the same name, containing tree structure as a user's `$HOME` directory, so to use my dotfiles for that application just copy them to the corresponding location in `$HOME` or create symlinks in the corresponding locations. If you are using Arch linux based distribution, you can install and configure applications with:

```
make <application name>
```

To use my default configuration, just run `make`. List of additional programs:
* ```make st```
* ```make yay```

You can write additional configurations which will extend the base dotfiles, by adding a folder in `$HOME/.dotfiles_ext`.
Currently an extension can contain:
* `Makefile` - will be run after installed after base `make`
* `.bashrc` - will be sourced in base `.bashrc`
* `.profile` - will be sourced in base `.profile`
