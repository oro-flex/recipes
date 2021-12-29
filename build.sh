mkdir -p .build && cd .build
# wget -q -O recipes-checker.zip https://codeload.github.com/symfony-tools/recipes-checker/zip/refs/heads/main
curl https://codeload.github.com/oro-flex/recipes-checker/zip/refs/heads/main -o recipes-checker.zip
unzip recipes-checker.zip
cd recipes-checker-main
composer install --ansi --no-dev
cd ..
cd ..
rm -rf flex-endpoint && mkdir -p flex-endpoint
git ls-tree HEAD */*/* | php .build/recipes-checker-main/run generate:flex-endpoint oro-flex/recipes master flex/main flex-endpoint
rm -rf .build
git checkout flex/main
git rm -q *.json
mv flex-endpoint/*.json .
cp -a flex-endpoint/archived .
rm -rf flex-endpoint
git add *.json
git add archived/
#git commit -m 'Update Flex endpoint' || true
#
# git push origin -f flex/main
