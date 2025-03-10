# bash options: 
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -x
set -e

git add .
git commit -m "$(date)"
git push origin source

bundle exec jekyll build
bundle exec octopress deploy
