#!/bin/bash

git checkout master

git reset --hard HEAD~1

git merge source

harp compile _harp ./

git add --all

git commit -m "Compile harp"

git push origin master -f

git checkout source
