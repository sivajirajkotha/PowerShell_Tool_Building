##https://git-scm.com/downloads
git clone "https://github.com/sivajikotha/MyFirstRepo.git"
git config --global user.name "sivajikotha"
git config --global user.email "sivajirajkotha@gmail.com"

git config --get user.name
#Make a folder to setup your Git repositories. You can do this by hand, or run the following:
New-Item -ItemType Directory 'c:\temp\Repos' -erroraction silentlycontinue

Set-Location c:\temp\Repos

git init MyFirstRepo
cd MyFirstRepo
Get-GitStatus

New-Item myfile.txt | Set-Content -Value "Sample text"
git status
git add .
git status
git commit -m "My first commit"
git log

git ls-tree --name-only HEAD
