## Package Managers in Arch Linux

Although Arch Linux comes with Pacman as the default package manager, you can install other package managers such as Yay. Unlike Pacman, these package managers allow you to add new packages from the official Arch repository and the AUR (Arch User Repository).

While other package managers have been used over the years, examples such as Yaourt and Aurman are no longer maintained. Consequently, Pacman and Yay are safer and more reliable package managers to rely on in Arch Linux.

AUR is a community-organized repository that provides users with a platform to share packages developed by them. If you are a developer, you can add packages to the AUR, and other users can install them on their system with ease.

### 1. Pacman

As mentioned above, every Arch system comes with Pacman as its default package manager. The most notable feature of Pacman is that it regularly syncs your system's packages with the master server, and in turn, keeps your system up to date.

### 2. Yay

As the developers of Yaourt and Aurman won't be releasing any updates after the discontinuation, Arch users have started using Yay to add packages from the AUR. The main aim of Yay was to minimize user input and to provide a Pacman-like interface.

You won't be able to install Yay using Pacman, as it does not support adding packages from the Arch User Repository directly. Therefore, you will have to install the Yay package manager manually using its Git repository. Here's how to install it on your system.

Step 1: You will require git to clone the yay repository.

```
pacman -S --needed git base-devel
```

Step 2: Clone the repository to your local storage.

```
git clone https://aur.archlinux.org/yay-git.git
```

Step 3: Change the permissions of the folder.

```
chmod 777 /yay-git
```

Step 4: Navigate to the directory where you cloned the repository.

```
cd yay-git
```

Step 5: Use the **makepkg** command to build the package. Make sure that you do not run the following command as the root user, otherwise, it will raise an error.

```
makepkg -si
```

## Updating and Upgrading Packages

If you have just installed Arch Linux, then before you can add or remove packages, you will have to sync your system with the master servers by updating your local package list.

Then, you can easily upgrade all of your packages to the latest version by downloading the files from official servers.

### Using Pacman

To update your package list using Pacman, use the **-Sy** flag with the command.

```
sudo pacman -Sy
```

After synchronizing your system's package list with the master servers, you need to upgrade the packages. Use the **-Syu** flag to do the same. This command can take some time depending on the list of the packages and your network connectivity.

```
sudo pacman -Syu
```

You can save the effort of typing both of these commands by combining them using the **-Syyu** flag. Pacman will start downloading the latest packages automatically after updating the package list.

```
sudo pacman -Syyu
```

### Using Yay

The Yay package manager allows you to update and upgrade your packages efficiently using your terminal. To do this, just use the **-Syu** flag with the yay command.

```
sudo yay -Syu
```

## Adding Packages

Adding packages is easy once you know which commands to execute. All you have to do is type the package manager commands in the terminal.

[Flathub and Snap Store](https://www.makeuseof.com/tag/flathub-vs-snap-store-linux-apps/) are two great GUI applications that you can use to install software and applications on your Linux machine.

### Install Packages With Pacman

Pacman uses the TAR file extension to package applications. It works efficiently with the Arch Linux system architecture. To add a package, you have to use the **-S** flag with the default command as follows.

```
sudo pacman -S packagename
```

For example,

```
sudo pacman -S cmatrix
```

To install multiple packages at once, type in the name of all the packages divided by the space character.

```
sudo pacman -S cmatrix vlc python
```

You can also get information about packages after installing them. The output provides details about the name, version, architecture, and license of the package. To do this, replace the **-S** flag with **-Qi** in the default **pacman** command.

```
pacman -Qi cmatrix
```

### Install Packages With Yay

The syntax of the Yay install command is pretty similar to that of Pacman. To install a package using the Yay package manager, just use the **-S** flag with the default command.

```
yay -S packagename
```

## Removing Packages in Arch

Arch Linux gives you the control to remove packages once you don't need them, and that's one of the many reasons [why you should install Arch Linux](https://www.makeuseof.com/tag/reasons-install-arch-linux/). You can remove almost any package from your system if you have the authorization, of course. Let's see how you can delete a package on Arch Linux.

### Remove Packages With Pacman

Removing a package is easy as well. All you have to do is use **-R** instead of the **-S** flag in the default **pacman** command.

```
sudo pacman -R cmatrix
```

If the package is not present in your system, you will receive an error output that will state "error: target not found: packagename".

### Remove Packages With Yay

To remove packages using Yay, add the **-R** flag to the default yay command. You can also use the -Rns flag to remove all unnecessary dependencies from your system.

```
yay -R cmatrixyay -Rns cmatrix
```

If you want to remove the packages that your system doesn't need, use the **-Yc** flag with the command.

```
yay -Yc
```

## Managing Packages on Arch Linux

There are multiple ways to add and remove packages on an Arch-based Linux distribution. You can use package managers such as Pacman, Yaourt, and Yay. While some package managers allow the download of packages from the Arch User Repository, others like Pacman do not support the AUR.

If you are not a fan of package managers, you can always download the packages you want manually. Several websites are available on the internet that provide TAR, RPM, and DEB packages to Linux users.