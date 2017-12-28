#!/bin/bash

# specify the client id, client secret and sso server here
source ./config

export SSO_CLIENT_ID=$client_id
export SSO_CLIENT_SECRET=$client_sec
export SSO_REDIRECT_URI=$redirect_uri
export CONSOLE_API_SCHEME=$console_api_scheme
export CONSOLE_LOG_LEVEL=${debug:-"INFO"}
export CONSOLE_APISERVER="http://deployd.lain:9003"
export CONSOLE_SENTRY_DSN=$console_sentry_dsn

mkdir -p /lain/logs
exec gunicorn -w 3 -b 0.0.0.0:8000 --max-requests=100 --timeout=240 --preload --error-logfile /lain/logs/error.log --access-logfile /lain/logs/access.log console.wsgi 
