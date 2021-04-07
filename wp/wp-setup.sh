#!/bin/bash

# WordPressセットアップ
wp core download --allow-root

wp core install --path='/var/www/html/' --url='http://localhost:10001' --title='The Project' --admin_user='admin' --admin_password='admin' --admin_email='iikentazuma@gmail.com' --allow-root

# 日本語化
wp language core install ja --activate --allow-root 

# タイムゾーンと日時表記
wp option update timezone_string 'Asia/Tokyo' --allow-root 
wp option update date_format 'Y-m-d' --allow-root 
wp option update time_format 'H:i' --allow-root

# キャッチフレーズの設定 (空にする)
wp option update blogdescription '' --allow-root

# プラグインの削除
wp plugin delete hello.php --allow-root

# プラグインのインストール
wp plugin install wp-multibyte-patch --activate --allow-root 
wp plugin install wordpress-importer --activate --allow-root 
wp plugin install mw-wp-form --activate --allow-root 
wp plugin install contact-form-7 --activate --allow-root 
wp plugin install advanced-custom-fields --activate --allow-root
wp plugin install custom-post-type-ui --activate --allow-root 
wp plugin install all-in-one-seo-pack --activate --allow-root 
wp plugin install custom-post-type-permalinks --activate --allow-root 
wp plugin install custom-permalinks --activate --allow-root 
wp plugin install acf-to-rest-api --activate --allow-root 
wp plugin install wp-gatsby --activate --allow-root
wp plugin install wp-graphql --activate --allow-root 
wp plugin install breadcrumb-navxt --activate --allow-root
wp plugin install advanced-nocaptcha-recaptcha --activate --allow-root
wp plugin install wp-pagenavi --activate --allow-root
wp plugin install contact-form-cfdb7 --activate --allow-root
#wp plugin install akismet --activate --allow-root


#wp plugin install jetpack --active --allow-root
#wp plugin install backwpup --active --allow-root
#wp plugin install siteguard --active --allow-root


# create scaffold empty_theme as API server
wp scaffold _s new-theme --theme_name="${THEMENAME}" --author="admin" --allow-root
wp theme activate new-theme --allow-root

# テーマの削除
wp theme delete --all --allow-root
#wp theme delete twentyseventeen --allow-root
#wp theme delete twentyeighteen --allow-root
#wp theme delete twentynineteen --allow-root