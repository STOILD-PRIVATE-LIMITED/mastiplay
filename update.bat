git checkout dev
git add .
<<<<<<< HEAD
git commit -m "New Update"
=======
git commit -m "New Update"
>>>>>>> 56d2eb8f3fdf26dc0d175011245bd628fba3e6e3
git checkout main
git pull
git merge dev
git push -u origin
git branch -d dev
git branch dev
git checkout dev