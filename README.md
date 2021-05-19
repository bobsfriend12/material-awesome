## Material and Mouse driven theme for [AwesomeWM 4.3-git](https://github.com/awesomeWM/awesome)

### Original work by [PapyElGringo](https://github.com/PapyElGringo), updated framework (and what this if forked from) by [manilarome](https://github.com/manilarome). PapyElGringo is now working on [Material-Shell](https://github.com/material-shell/material-shell) instead.


Note: This is my personal config, I am willing to accept pull requests that fix bugs or adds features that are missing. As this is pretty much a freetime project by someone who is not familiar with lua, do not expect this to be under super active development by me(as I know little to no lua).
This is why I recommend you to fork this project and use that to store your own personal config and just use this as a base.


## What is Material-Awesome?
An almost desktop environment made with [AwesomeWM](https://awesomewm.org/) mostly following the [Material Design guidelines](https://material.io) with a performant opiniated mouse/keyboard workflow to increase daily productivity and comfort.

| Tiled         | Panel         | Exit screen   | Notification center  |
|:-------------:|:-------------:|:-------------:|:--------------------:|
|![](https://i.imgur.com/35ssPBe.png)|![](https://i.imgur.com/BGzDsSO.png)|![](https://i.imgur.com/NEehdQL.png)|![](https://i.imgur.com/dUyI3dG.png)



## I have an issue, can I get help?
I am pretty much most likely as green as you when it comes to lua, but you can submit an issue in the issue tracker and me or someone else will attempt to help you if we know the answer.<br>

Feel free to @HikariKnight in the issue message too to send me a mail notification!


## Known bugs
* Clicking a notification does not raise the window/application that sent it.<br>
This seems to be an issue with the new notification api that uses dbus in awesomewm



## Installation
### Note: the best transition is from gnome or mate to material-awesome as KDE-plasma can break some indicators until plasma is purged entierly.

### 1) Get all the dependencies
- [AwesomeWM](https://github.com/awesomeWM/awesome) as the window manager (you will need to build awesome from source using the master branch)
- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font**
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher
- [Picom](https://github.com/yshui/picom) for the compositor (you will have to build it from source, compton is not compatible!)
- [i3lock-fancy](https://github.com/meskarune/i3lock-fancy) the lockscreen application
- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard
- __gnome-keyring-daemon__ and a __policykit-agent__ (by default policykit-1-gnome is enabled)
- (Optional) __qt5-styles-gtk2__ or __qt5-styles-plugins__ for making QT and KDE applications look the same as gnome applications (standalone QT applications will still show up using their default theme, this cannot be fixed!)
- (Optional) [Materia](https://github.com/nana-4/materia-theme) as GTK theme
- (Optional) [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme
- (Optional) [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme
- (Optional) **xrandr** to adjust laptop brightness (LVDS output)
- (Optional) [Ksnip](https://github.com/ksnip/ksnip) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the screenshot utility script!
- (Optional) [Redshift](https://github.com/jonls/redshift) For blue light filter

### 2) Add the awesomewm session file if it was not created
After installing all the dependencies (and compiled and installed awesomewm from source!)<br>
Run the below command
```
ls /usr/share/xsessions
```
If the above command does not list an awesome.desktop file then copy the below text into `/usr/share/xsessions/awesomewm.desktop`
```ini
[Desktop Entry]
Name=awesome
Comment=Highly configurable framework window manager
TryExec=awesome
Exec=awesome
Type=Application
Icon=/usr/share/pixmaps/awesome.xpm
Keywords=Window manager
```

### 3) Clone the configuration

```
git clone https://github.com/HikariKnight/material-awesome.git ~/.config/awesome
```

> This theme requires the current (as of 23.02.2021) **master** branch of Awesome, it does not work on Awesome 4.3-stable which is what most distros ship. If you want to install the older config on Awesome4.3-stable or Awesome 4.2 use the specific awesome-4.2 or awesome4.3-stable branch (not in development by me)

Awesome4.3-stable (older version with less features, no longer maintained, browse the branch for install requirements!)
```
git clone -b awesome4.3-stable https://github.com/HikariKnight/material-awesome.git ~/.config/awesome
```

Awesome4.2
```
git clone -b awesome-4.2 https://github.com/PapyElGringo/material-awesome.git ~/.config/awesome
```

### 4) Set the themes
Start **lxappearance** to active the **icon** theme and **GTK** theme
Note: for cursor theme, edit `~/.icons/default/index.theme` and `~/.config/gtk3-0/settings.ini`, for the change to also show up in applications run as root, copy the 2 files over to their respective place in `/root`.

### 5) Same theme for Qt/KDE applications and GTK applications, and fix missing indicators
First install `qt5-style-plugins` (or `qt5-style-gtk2`) and add this to the bottom of your `/etc/environment`

```bash
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```

The first variable fixes most indicators (especially electron based ones!), the second tells most Qt and KDE applications (from your distributions repository) to use your gtk2 theme set through lxappearance.


### 6) Do your basic configuration
Open [apps.lua](./configuration/apps.lua) and [config.lua](configuration/config.lua) and make your changes.<br>
I recommend you to make your own fork of this project!

You can search the code to find the file you are looking for using this command if you ever plan to edit the source files directly.
```
grep -Ri "what you are searching for" ~/.config/awesome/
```


### 7) Read the documentation
The documentation live within the source code.

The project is split in functional directories and in each of them there should be a readme where you can get additionnal informations about the contents of the folder.

* [Configuration](./configuration) is about all the **settings** available
* [Layout](./layout) hold the **disposition** of all the widgets (panels, dashboard layout, etc)
* [Module](./module) contain all the **features** available
* [Theme](./theme) hold all the **aestetic** aspects
* [Widget](./widget) contain all the **widgets** available
* [Utilities](./utilities) contains all the utility scripts
