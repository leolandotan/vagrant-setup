sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc
# echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc

echo "\n--- Installing drush ---\n"
composer global require drush/drush:6.*

source $HOME/.bashrc
# source ~/.bashrc