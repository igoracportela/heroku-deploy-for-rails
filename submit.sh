#!/bin/sh

deploy()
{
  ENV=$1
  echo "Starting deployment to - $ENV"
  git push $ENV master:master
  heroku run rake db:migrate --remote $ENV
}

check_login()
{
  if heroku whoami; then
    return
  fi

  false
}

if check_login; then
  deploy heroku-staging
  deploy heroku-prod
else
  echo "Firstly, login to heroku with the command: heroku login"
  echo ""
fi
