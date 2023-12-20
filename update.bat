REM Set the commit message or use "New Update" by default
set commit_message=%1
if "%commit_message%"=="" set commit_message=New Update
git checkout dev
git add .
git commit -m "%commit_message%"
git checkout main
git pull
git merge dev
git push -u origin
git branch -d dev
git branch dev
git checkout dev