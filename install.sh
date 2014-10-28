#!/bin/bash

# Clear drupal sql database
#drush sql-drop

repo init -u git://github.com/surveyTW/manifest -m survey.xml
repo sync -dq

git checkout `git describe --abbrev=0`
echo ".repo" >> .gitignore

# Download modules
drush dl admin_menu
drush dl ctools
drush dl button_field
drush dl entity
drush dl jquery_update
drush dl module_filter
drush dl options_element
drush dl rules
drush dl views
drush dl webform
#drush dl devel
#drush dl examples

# Download themes
drush dl bootstrap

mkdir sites/default/files
cp sites/default/default.settings.php sites/default/settings.php

# Do settings via browser


# After setup drupal
chmod 444 sites/default/settings.php

# Enable modules
drush en webform -y
drush en module_filter -y
drush en admin_menu -y
drush en jquery_update -y
drush en bundle_copy -y

# Enable themes
drush en bootstrap -y

