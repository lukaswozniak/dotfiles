# Dotfiles
My dotfiles are kept in folders containing tree structure as a user's `$HOME` directory, so to use my dotfiles for that application just copy them to the corresponding location in `$HOME` or create symlinks in the corresponding locations.

If you are using Arch linux based distribution, you can install and configure applications with:
```
make arch
```
Additionally for AUR helper yay:
```
make yay
```

For Debian based distributions:
```
make debian
```

Installing and configuring can be done in two steps:
```
make install_arch
make configure
```

You can write additional configurations which will extend the base dotfiles, by adding a folder in `$HOME/.dotfiles_ext`.
Template for an extension is in folder `extensions/.dotfiles_ext/template`.
Currently an extension must contain:
* `Makefile` - with targets `install_arch`, `install_debian` and `configure`. Will be run after corresponding base target.
* `.bashrc` - (optional) will be sourced in base `.bashrc`
* `.profile` - (optional) will be sourced in base `.profile`
