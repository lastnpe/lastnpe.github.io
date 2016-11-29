#!/usr/bin/env bash
set -e # halt script on error

# https://jekyllrb.com/docs/continuous-integration/
bundle exec jekyll build
bundle exec htmlproofer ./_site --url-ignore "/#.*/"
# https://github.com/gjtorikian/html-proofer/issues/118
