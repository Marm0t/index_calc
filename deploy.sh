#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

export GIT_SSH_COMMAND="ssh -i /tmp/git_deploy_key"

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:Marm0t/index_calc.git master:gh-pages



cd -
