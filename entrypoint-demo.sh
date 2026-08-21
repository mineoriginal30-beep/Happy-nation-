#!/bin/sh
set -eu

: "${PORT:=10000}"
: "${APP_ENV:=production}"
: "${APP_DEBUG:=false}"
: "${APP_URL:=http://${RENDER_EXTERNAL_HOSTNAME:-localhost}}"
: "${DB_CONNECTION:=sqlite}"
: "${DB_DATABASE:=/var/www/html/database/database.sqlite}"

export PORT APP_ENV APP_DEBUG APP_URL DB_CONNECTION DB_DATABASE

if [ "$DB_CONNECTION" = "sqlite" ]; then
  mkdir -p "$(dirname "$DB_DATABASE")"
  touch "$DB_DATABASE"
fi

mkdir -p storage/framework/cache/data storage/framework/sessions storage/framework/views storage/logs bootstrap/cache database

php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan migrate --force
php artisan db:seed --force
php artisan storage:link || true
php artisan config:cache
# The project uses include_once route groups that are omitted by Laravel's
# route:cache command in this sanitized build. Keep the route cache cleared so
# all public API and authentication routes are loaded from routes/api.php.
php artisan route:clear
php artisan view:cache

sed -ri "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
sed -ri "s/:80>/:${PORT}>/g" /etc/apache2/sites-available/*.conf
exec apache2-foreground
