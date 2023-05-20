#!/usr/bin/env bash
# exit on error
# https://render.com/docs/deploy-rails#update-your-app-for-render
set -o errexit

bundle install
yarn install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed