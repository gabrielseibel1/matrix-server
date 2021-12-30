CONTENT_ROOT = /var/www/pimatrixconduit
SITE = pimatrixconduit.xyz
SITE_AVAILABLE = /etc/nginx/sites-available/${SITE}
SITE_ENABLED = /etc/nginx/sites-enabled/${SITE}
STICKERS = stickerpicker/web
INDEX_HTML = index.html
USAGE_HTML = docs/usage.html

all : index docs

index : index.md
	python3 -m markdown index.md -f ${INDEX_HTML}

docs : usage

usage : docs/usage.md
	python3 -m markdown docs/usage.md -f ${USAGE_HTML}

install : docs index nginx stickerpicker ${CONTENT_ROOT}
	find . -type f -exec sed -i 's/.md/.html/g' {} \; # replace md references with html ones
	mv ${INDEX_HTML} ${CONTENT_ROOT}
	mv ${USAGE_HTML} ${CONTENT_ROOT}
	mv nginx/nginx.conf /etc/nginx/nginx.conf
	mv nginx/pimatrixconduit.xyz ${SITE_AVAILABLE}
	ln -s ${SITE_AVAILABLE} ${SITE_ENABLED}
	ln -s ${STICKERS} ${CONTENT_ROOT}/${STICKERS}
