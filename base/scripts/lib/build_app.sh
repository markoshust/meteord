set -e

COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues
# this fixes that
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH

meteor build --directory $BUNDLE_DIR --server=http://localhost:3000

cd $BUNDLE_DIR/bundle/programs/server/
npm i
mv $BUNDLE_DIR/bundle/programs/server/node_modules $BUNDLE_DIR/bundle/

cp $COPIED_APP_PATH/package.json $BUNDLE_DIR/bundle/
cd $BUNDLE_DIR/bundle/
npm i
ln -s node_modules programs/server/node_modules
ln -s node_modules programs/web.browser/node_modules
ln -s node_modules programs/web.cordova/node_modules

mv $BUNDLE_DIR/bundle /built_app

# cleanup
rm -rf $COPIED_APP_PATH
rm -rf $BUNDLE_DIR
rm -rf ~/.meteor
rm /usr/local/bin/meteor
