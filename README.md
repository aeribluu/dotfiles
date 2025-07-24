# i3wm Dotfiles

These are my personal dotfiles, managed with GNU Stow. 

## Prerequisites

Before you begin, make sure you have the following installed on your system:

* **Git:** For cloning this repository.
* **GNU Stow:** For symlinking the dotfiles to your home directory.

You can typically install these using your system's package manager (e.g., `apt`, `pacman`, `dnf`, `brew`), e.g.

```
$ sudo pacman -S git stow
```

## How to use these dotfiles on a new system

1.  **Clone the repository:**

    ```
    $ git clone https://github.com/aeribluu/dotfiles.git
    ```

2.  **Navigate into the dotfiles directory:**

    ```
    $ cd ~/.dotfiles
    ```

3.  **Stow the desired packages:**

    For example, to link your Neovim configuration:

    ```
    $ stow nvim
    ```

    To link all dotfiles:

    ```
    $ stow *
    ```

    *Note: If you encounter errors about existing files, you may need to manually remove the existing configuration files/directories before stowing.*

    *Note: [GNU Stow tutorial](https://www.youtube.com/watch?v=y6XCebnB9gs).*
