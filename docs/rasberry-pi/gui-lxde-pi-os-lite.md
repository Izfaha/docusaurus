---
sidebar_title: Install GUI on Raspi OS Lite
sidebar_position: 8
---

# Install GUI on Raspi OS Lite using LXDE

## Install Depedencies

First, install all depedencies

```sh
sudo apt update && apt upgrade -y

# install all depedencies
sudo apt install lxde lxde-core lxsession lxappearance lightdm lxterminal xserver-xorg xinit dbus-x11 lightdm -y
```

:::note[Keep in mind]
If you are asked "Default display manager.", chose: lightdm.
:::

## LightDM Configuration

You neet to verify that all of Environment.

```sh
ls -la /usr/share/xsession/
```

1. LXDE.desktop             (This is the main core and I will utilize it.)
2. lxde-pi.desktop
3. openbox.desktop
4. LXDE-pi-labw.desktop

Then, configure the lightdm conf. Edit file `/etc/lightdm/lightdm.conf`.

```sh
sudo nano /etc/lightdm/lightdm.conf
```

Edit `autologin-user=your_user` and `autologin-session=LXDE`.

```sh
[Seat:*]
autologin-user=anaklanang
autologin-session=LXDE
```

Restart lightdm using

```sh
sudo systemctl restart lightdm
```

Automate Login GUI after live boot.

```sh
sudo raspi-config
```

-> Chose **1. System Options**\
-> Chose **S5. Boot/Auto Login**\
-> Chose **B2. Console Autologin with Desktop GUI**

Then, reboot.

```sh
reboot
```

## Error solver

if you do not enter the LDX GUI session, run this command in **tty**.
You can enter TTY session using 'CTRL + ALT + F1 - F6'. Login as your user and run these command.

```sh
startx 
# or startlxde
```

it will start the Xorg server.

Also, you can check log in `.xsession-errors` and `/var/log/lightdm/lightdm.log`.

## Additional Command


