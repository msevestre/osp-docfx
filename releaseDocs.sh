#!/bin/sh
set -e

# docfx ./docfx_project/docfx.json

SOURCE_DIR=$PWD
TEMP_REPO_DIR=$PWD/../docfx-gh-pages

echo "Removing temporary doc directory $TEMP_REPO_DIR"
rm -rf $TEMP_REPO_DIR
mkdir $TEMP_REPO_DIR

echo "Cloning the repo with the gh-pages branch"
git clone https://github.com/msevestre/osp-docfx.git --branch gh-pages $TEMP_REPO_DIR

echo "Clear repo directory"
cd $TEMP_REPO_DIR
git rm -r *

echo "Copy documentation into the repo"
cp -r $SOURCE_DIR/docfx_project/_site/* .

echo "Copy pdf into the repo"
mkdir pdf
cp $SOURCE_DIR/docfx_project/_site_pdf/docfx_project_pdf.pdf ./pdf/osp.pdf

echo "Push the new docs to the remote branch"
git add . -A
git commit -m "Update generated documentation"
git push origin gh-pages

echo "Cleaning up"
cd ..
rm -rf ./docfx-gh-pages
