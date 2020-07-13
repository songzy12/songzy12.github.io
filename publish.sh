set -x

git add .
git commit -m "$(date)"
git push origin source

jekyll build
octopress deploy
