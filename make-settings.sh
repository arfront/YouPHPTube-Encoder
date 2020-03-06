#!/bin/bash

echo "<?php
\$global['webSiteRootURL'] = 'https://dev.encoder.poy.cn/';
\$global['systemRootPath'] = '/var/www/html/';

\$global['disableConfigurations'] = false;
\$global['disableBulkEncode'] = false;
\$global['disableWebM'] = false;

\$mysqlHost = '$DATABASE_HOST';
\$mysqlUser = '$DATABASE_USER';
\$mysqlPass = '$DATABASE_PWD';
\$mysqlDatabase = '$DATABASE_NAME'.'_encoder';

\$global['allowed'] = array('mp4', 'avi', 'mov', 'flv', 'mp3', 'wav', 'm4v', 'webm', 'wmv', 'mpg', 'mpeg', 'f4v', 'm4v', 'm4a', 'm2p', 'rm', 'vob', 'mkv', '3gp');

/**
 * Do NOT change from here
 */

require_once \$global['systemRootPath'].'objects/include_config.php';" > /var/www/html/videos/configuration.php

exec "$@"