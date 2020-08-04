#!/bin/sh -l
git clone --quiet https://github.com/$repository &> /dev/null

sha=$(git rev-list --tags --max-count=1)
tag=$(git describe --tags $sha)
git-chglog --output changelog.md $tag

changelog=$(cat changelog.md)
changelog="${changelog//'%'/'%25'}"
changelog="${changelog//$'\n'/'%0A'}"
changelog="${changelog//$'\r'/'%0D'}"

echo "::set-output name=changelog::$changelog"
