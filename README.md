
New post:

```
octopress new post hello -D Ruby
```

Deploy:

```
set -x

git add .
git commit -m "$(date)"
git push origin source

jekyll build
octopress deploy
```

