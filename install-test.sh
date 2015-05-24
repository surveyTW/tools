#!/bin/bash

# Global git configuration
git config --global user.name "Someone"
git config --global user.email "someone@gmail.com"

# Clear drupal sql database
#drush sql-drop

repo init -u git://github.com/surveyTW/manifest -m survey.xml
# Do <repo init -m survey.xml --config-name> if you want to change username/email
repo sync -j 5

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
drush dl entity_translation
drush dl variable
drush dl i18n
drush dl l10n_update

# Download themes
drush dl bootstrap


# Create mysql db
#
# mysql -u root -p
# create database drupaldb;
# create user 'user'@'localhost' identified by 'passwd';
# GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON drupaldb.* TO 'user'@'localhost' IDENTIFIED BY 'passwd';

# Do drupal install settings
#    --db-url=<mysql://user:password@host/dbname>
drush site-install standard --site-name='Survey' --account-name='root' --account-pass='112233' --db-url=mysql://root:drupal7@localhost/drupal-testdb --clean-url

# Update httpd configuration for clean URL
touch /etc/httpd/conf.d/test-server.conf
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
drush en locale -y
drush en entity_translation -y
drush en i18n -y
drush en l10n_update -y
drush en menu_item_visibility -y
drush en htmlmail -y
drush en smtp -y
drush en login_destination -y

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

#copy file from tool
git clone https://github.com/surveyTW/tools
cp -rf tools/mailsystem sites/default/files/mailsystem
#rm -rf tools

# Import content type from https://github.com/surveyTW/tools/blob/master/settings/survey/content_type.txt



# Note
#
# 1. Use Drush to Export a Drupal MySQL Database:
#   drush cc
#   drush sql-dump > ~/my-sql-dump-file-name.sql
#
# 2. Use Drush to Import a Drupal MySQL Database:
#   drush sql-drop
#   drush sql-cli < ~/my-sql-dump-file-name.sql
#   goto http://<ip>//update.php?op=info
#
#記得設site/default權限 site/default/file的owner,local server的話要設rewritebase(.htaccess)

