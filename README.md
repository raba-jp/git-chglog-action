# git-chglog-action

GitHub Action for [git-chglog/git-chglog](https://github.com/git-chglog/git-chglog). Intended to be used with actions/create-release.

## Example workflow

```yaml
on:
  push:
    # Sequence of patterns matched against refs/tags
    tags:
      - "v*" # Push events to matching v*, i.e. v1.0, v20.15.10

name: Create Release

jobs:
  build:
    name: Create Release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: changelog
        uses: raba-jp/git-chglog-action@master
        id: changelog
        with:
          version: "0.9.1"
          os: "linux" # optional
          arch: "amd64" # optional
          repository: ${{ github.repository }}
          tag: ${{ github.ref }}
      - name: Create Release
        id: create_release
        uses: actions/create-release@latest
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # This token is provided by Actions, you do not need to create your own token
        with:
          tag_name: ${{ github.ref }}
          release_name: ${{ github.ref }}
          body: |
            ${{ steps.changelog.outputs.changelog }}
          draft: false
          prerelease: false
```
