#! /bin/bash
sudo yum update -y
#sudo amazon-linux-extras install -y php7.3
#sudo yum install -y httpd php gd php-gd php-xml php-json php-mbstring php-process php-common php-zip php-mysqlnd php-opcache
sudo yum install -y httpd
#php -v
#sudo yum install -y nfs-utils
#sudo yum install -y cachefilesd
#sudo yum install -y java-1.8.0-openjdk.x86_64
#sudo yum install -y php-soap.x86_64
#sudo service cachefilesd start
#sudo chkconfig cachefilesd on
sudo mkdir -p /var/www/html/web/www
sudo systemctl start httpd
systemctl enable httpd.service

sudo cat > /var/www/html/index.html <<EOF
	  <html lang="en" dir="ltr">
		<head>
		  <meta charset="utf-8">
		  <title>Welcome to Test Demo Page</title>
		  <style media="screen">
			body {
			  background-color: #3FBFBF;
			}
		  </style>
		</head>
		<body>
		<h1>Welcome to test env 1</h1>
		<p>Testing webservers</p>
		<p>This is traffic from node 1</p>

		</body>
	  </html>
EOF

