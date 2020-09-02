#!/bin/bash
echo "------ warning! start sync blog to current directory."
git clone git@github.com:minicloudsky/blog-backup.git
echo "------ start sync themes."
cd blog
npm install

git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia
cp -r theme_config/_config.yml themes/yilia/
cp -r theme_config/index.js  node_modules/hexo-asset-image/index.js 


