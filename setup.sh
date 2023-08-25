#!/bin/bash
#
# Author: Marco Guidara
# Date: August 24, 2023
# Name: setup.sh
# Purpose: Self destroying .sh file. Install latest WP Bedrock version and most used plugins.

currentscript=$0

function finish {
    echo "Remove .git folder.";
    echo;
    rm -rf ./.git;
    
    echo "shredding ${currentscript}"; 
    rm ${currentscript};

    echo "Setup procedure completed.";
    echo
}

echo "Install Bedrock";
echo;
composer create-project roots/bedrock;
mv ./bedrock/* .;
rm -r ./bedrock;

echo "Install Plugins";
echo;

composer require wpackagist-plugin/timber-library;
composer require wpackagist-plugin/acf-extended;
composer require wpackagist-plugin/wp-migrate-db;
composer require wpackagist-plugin/wordpress-seo;
composer require wpackagist-plugin/duplicate-page;
composer require wpackagist-plugin/contact-form-7;
composer require wpackagist-plugin/wp-mail-smtp;
composer require wpackagist-plugin/contact-form-7-dynamic-text-extension;

composer upgrade;


cp -r ./web/app/plugins/timber-library/timber-starter-theme ./web/app/themes/

trap finish EXIT;