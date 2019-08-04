

echo "|> Making zsh the default shell ..."
chsh -s "$(which zsh)"

read -p "|> All done! Please re-login to apply changes (press any key to continue...) " -n 1 -r
echo

