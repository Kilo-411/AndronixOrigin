#!/bin/bash
echo "Removing distribution provided chromium packages and dependencies..."
sudo apt purge chromium* chromium-browser* -y -qq && apt autoremove -y -qq
echo "Enabling PPA support..."
[ ! -f .parrot ] && apt update -qq; apt install software-properties-common gnupg --no-install-recommends -y -qq
echo " Adding chromium-team stable ppa"
sudo add-apt-repository ppa:ultrahacx/chromium-universal -y
apt update -qq; apt install chromium-browser --no-install-recommends -y
echo "Patching application shortcuts..."
sed -i 's/chromium-browser %U/chromium-browser --no-sandbox %U/g' /usr/share/applications/chromium-browser.desktop
echo 'alias chromium="chromium-browser --no-sandbox" >> /etc/profile'
echo "You can now start chromium by using the application icon or by typing chromium" && . /etc/profile
