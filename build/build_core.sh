#!/bin/bash -e

compress-js plugins/ajax/plg_ajax_xtwssipe/media/js/xtwssipe.js > plugins/ajax/plg_ajax_xtwssipe/media/js/xtwssipe.min.js

npm run build
