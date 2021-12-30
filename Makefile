CONTENT_ROOT = /var/www/pimatrixconduit
SITE = pimatrixconduit.xyz
SITE_AVAILABLE = /etc/nginx/sites-available/${SITE}
SITE_ENABLED = /etc/nginx/sites-enabled/${SITE}
STICKERS = stickerpicker/web
INDEX_HTML = index.html
USAGE_HTML = docs/usage.html
IMAGES = docs/img

all : index docs

index : index.md
	python3 -m markdown index.md -f ${INDEX_HTML}

docs : usage

usage : docs/usage.md
	python3 -m markdown docs/usage.md -f ${USAGE_HTML}

install : docs index nginx stickerpicker ${CONTENT_ROOT}
	find . -type f -exec sed -i 's/.md/.html/g' {} \; # replace md refs for html
	mkdir  -p ${CONTENT_ROOT}/docs
	cp -f  ${INDEX_HTML} ${CONTENT_ROOT}/${INDEX_HTML}
	cp -f  ${USAGE_HTML} ${CONTENT_ROOT}/${USAGE_HTML}
	cp -rf ${IMAGES}     ${CONTENT_ROOT}/${IMAGES}
	cp -f  nginx/nginx.conf /etc/nginx/nginx.conf
	cp -f  nginx/pimatrixconduit.xyz ${SITE_AVAILABLE}
	cp -f  ${SITE_AVAILABLE} ${SITE_ENABLED}
	cp -rf ${STICKERS} ${CONTENT_ROOT}/${STICKERS}
