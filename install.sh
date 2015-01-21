#!/bin/bash

# Clear drupal sql database
#drush sql-drop

repo init -u git://github.com/surveyTW/manifest -m survey.xml
repo sync -dq

git checkout `git describe --abbrev=0`
echo ".repo" >> .gitignore


# Download modules
drush dl admin_menu
drush dl bundle_copy
drush dl button_field
drush dl ctools
#drush dl devel
#drush dl examples
drush dl entity
drush dl jquery_update
drush dl libraries
drush dl module_filter
drush dl options_element
drush dl phpmailer
drush dl rules
drush dl views
drush dl webform
drush dl simple_fb_connect

# Download themes
drush dl bootstrap


# Do drupal install settings
#    --db-url=<mysql://root:pass@host/db>
drush site-install standard --site-name='Survey' --account-name='root' --account-pass='112233' --db-url=mysql://drupal7:ubuntu@localhost/drupaldb --clean-url

# Update httpd configuration for clean URL
touch /etc/httpd/conf.d/drupal.conf
#<Directory 'PATH'>
#    AllowOverride All
#</Directory>

# Enable modules
drush en webform -y
drush en module_filter -y
drush en admin_menu_toolbar -y
drush en jquery_update -y
drush en bundle_copy -y
drush en libraries -y
drush en simple_fb_connect -y
drush en surveydate -y

drush dis overlay -y
drush dis toolbar -y

# Enable themes
drush en bootstrap -y
drush en survey -y


# Setup basic configuration
drush vset date_first_day 0
drush vset site_default_country 'TW'
drush vset user_default_timezone '0'
drush vset configurable_timezones 1
drush vset date_default_timezone 'Asia/Taipei'
drush vset jquery_update_compression_type 'min'
drush vset jquery_update_jquery_cdn 'google'
drush vset theme_default 'survey'

# Import content type from https://github.com/surveyTW/tools/blob/master/settings/survey/content_type.txt

