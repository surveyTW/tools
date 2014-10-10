#!/bin/bash

# Clear drupal sql database
#drush sql-drop

repo init -u git://github.com/surveyTW/manifest -m survey.xml
repo sync -dq

git checkout `git describe --abbrev=0`
echo ".repo" >> .gitignore

# download modules
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

# download themes
drush dl bootstrap

mkdir sites/default/files
cp sites/default/default.settings.php sites/default/settings.php

# do settings via browser


# enable modules
drush en webform
drush en module_filter
drush en admin_menu
drush en bootstrap
drush en jquery_update

