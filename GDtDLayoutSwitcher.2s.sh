#!/usr/bin/env bash

#
# GDtDLayoutSwitcher (GNOME Dash to {Dock,Panel} Layout Switcher) by github.com/BobyMCbobs
#
# A simple program to switch between 'dash to dock' and 'dash to panel'

# Licensed under GPL v3

disable_argos_demo_script=1

if [ -f $HOME/.config/argos/argos.sh ] && [ -x $HOME/.config/argos/argos.sh ] && [ $disable_argos_demo_script = 1 ]
then
	chmod -x $HOME/.config/argos/argos.sh > /dev/null 2>&1
fi

echo "Desktop Layout"
echo "---"

extension1="dash-to-dock@micxgx.gmail.com"
extension2="dash-to-panel@jderose9.github.com"

function opt_adapt_to_dock() {

echo "Change to dock | terminal=false bash='gnome-shell-extension-tool -d $extension2 > /dev/null 2>&1; gnome-shell-extension-tool -e $extension1 > /dev/null 2>&1; sleep 0.5s; while gsettings get org.gnome.shell enabled-extensions | grep $extension2 > /dev/null 2>&1; do gnome-shell-extension-tool -d $extension2 > /dev/null 2>&1; done; while ! gsettings get org.gnome.shell enabled-extensions | grep $extension1 > /dev/null 2>&1; do gnome-shell-extension-tool -e $extension1 > /dev/null 2>&1; done'"

}

function opt_adapt_to_taskbar() {

echo "Change to taskbar | terminal=false bash='gnome-shell-extension-tool -d $extension1 > /dev/null 2>&1; gnome-shell-extension-tool -e $extension2 > /dev/null 2>&1; sleep 0.5s; while gsettings get org.gnome.shell enabled-extensions | grep $extension1 > /dev/null 2>&1; do gnome-shell-extension-tool -d $extension1 > /dev/null 2>&1; done; while ! gsettings get org.gnome.shell enabled-extensions | grep $extension2 > /dev/null 2>&1; do gnome-shell-extension-tool -e $extension2 > /dev/null 2>&1; done'"

}

function check_if_installed() {

locations="/usr/share/gnome-shell/extensions $HOME/.local/share/gnome-shell/extensions"
output=""

if [ ! -d /usr/share/gnome-shell/extensions/$extension1 ] && [ ! -d $HOME/.local/share/gnome-shell/extensions/$extension1 ]
then
	output="1"
	echo "'$extension1' is not installed -- Click here to install it. | terminal=false bash='echo Downloading Dash to Dock... > $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Dock.sh; echo --- >> $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Dock.sh; chmod +x $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Dock.sh ;if [ ! -d $HOME/.local/share/gnome-shell/extensions ]; then mkdir -p $HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com; fi; cd /tmp; wget -O - https://extensions.gnome.org/review/download/7799.shell-extension.zip > dash-to-dock.zip; unzip dash-to-dock.zip -d $HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com; rm /tmp/dash-to-dock.zip; cd; rm $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Dock.sh'"
fi

if [ ! -d /usr/share/gnome-shell/extensions/$extension2 ] && [ ! -d $HOME/.local/share/gnome-shell/extensions/$extension2 ]
then
	output="$output 2"
	echo "'$extension2' is not installed -- Click here to install it. | terminal=false bash='echo Downloading Dash to Dock... > $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Panel.sh; echo --- >> $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Panel.sh; chmod -x $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Panel.sh; if [ ! -d $HOME/.local/share/gnome-shell/extensions ]; then mkdir -p $HOME/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com; fi; cd /tmp; wget -O - https://github.com/jderose9/dash-to-panel/archive/v12.zip > dash-to-panel.zip; unzip dash-to-panel.zip -d $HOME/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com; rm /tmp/dash-to-panel.zip; cd; rm $HOME/.config/argos/G_D-t-D_Downloading_Dash_to_Panel.sh'"
fi

if [[ -z $output ]]
then
	return 0
else
	return 1
fi

}

function adapt_to_dock() {
	gnome-shell-extension-tool -d $extension2 > /dev/null 2>&1; gnome-shell-extension-tool -e $extension1 > /dev/null 2>&1
}

function adapt_to_taskbar() {
	gnome-shell-extension-tool -d $extension1 > /dev/null 2>&1; gnome-shell-extension-tool -e $extension2 > /dev/null 2>&1
}

if ! check_if_installed
then
	exit
fi

if gsettings get org.gnome.shell enabled-extensions | grep $extension1 > /dev/null 2>&1 && gsettings get org.gnome.shell enabled-extensions | grep $extension2 > /dev/null 2>&1
then
	echo "ERROR, please select taskbar or dock."
	opt_adapt_to_dock
	opt_adapt_to_taskbar

elif gsettings get org.gnome.shell enabled-extensions | grep $extension1 > /dev/null 2>&1
then
	opt_adapt_to_taskbar

elif gsettings get org.gnome.shell enabled-extensions | grep $extension2 > /dev/null 2>&1
then
	opt_adapt_to_dock
else
	echo "ERROR, neither taskbar or dock enabled -- Please select one."
	opt_adapt_to_dock
	opt_adapt_to_taskbar
fi

refresh=true
