CONTENT_ROOT = /var/www/pimatrixconduit
ETC_NGINX = /etc/nginx
SITE = pimatrixconduit.xyz
SITES_AVAILABLE = ${ETC_NGINX}/sites-available
SITES_ENABLED = ${ETC_NGINX}/sites-enabled
STICKERS = stickerpicker/web
INDEX_HTML = index.html
USAGE_HTML = docs/usage.html
IMAGES = docs/img

compile : index docs

index : index.md
	python3 -m markdown index.md -f ${INDEX_HTML}

docs : usage

usage : docs/usage.md
	python3 -m markdown docs/usage.md -f ${USAGE_HTML}

install : docs index nginx stickerpicker ${CONTENT_ROOT}
	find . -type f -exec sed -i 's/.md/.html/g' {} \; # replace md refs for html
	mkdir  -p ${CONTENT_ROOT}/docs
	cp -rf --parents  \
		${INDEX_HTML} \
		${USAGE_HTML} \
		${IMAGES} \
		${STICKERS} \
		${CONTENT_ROOT}
	cp -f  --parents nginx/${SITE} ${SITES_AVAILABLE}
	cp -f  --parents nginx/${SITE} ${SITES_ENABLED}
	cp -i  --parents nginx/nginx.conf ${ETC_NGINX}/nginx.conf

${CONTENT_ROOT} :
	mkdir -p ${CONTENT_ROOT}
