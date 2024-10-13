#!/usr/bin/env sh

npm run ng build
npm run ng serve --host 0.0.0.0 --port 4200 &
sleep 1
echo $! > .pidfile

echo 'MHM. Now...'
echo 'Visit http://localhost:4200 to see your Node.js/Angular application in action.'
