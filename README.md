# Dotfiles

Each application's dotfiles are kept in a folder of the same name. Each application's folder has the same tree structure as a user's `$HOME` directory, so to use my dotfiles for that application just copy them to the corresponding location in `$HOME` or create symlinks in the corresponding locations. If you have `stow` installed, you can do this simply with:

```
make <application name>
```

To use my default configuration, just run `make`.
