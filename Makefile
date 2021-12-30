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
	sed -i 's/.md/.html/g' ${INDEX_HTML}

docs : usage # separate rule to add more than 'usage'

usage : docs/usage.md
	python3 -m markdown docs/usage.md -f ${USAGE_HTML}
	sed -i 's/.md/.html/g' ${USAGE_HTML}

install : nginx stickerpicker nginx_installed
	cp -rf --parents \
		${INDEX_HTML} \
    ${USAGE_HTML} \
    ${IMAGES} \
    ${STICKERS} \
    ${CONTENT_ROOT}
	cp -i  nginx/nginx.conf ${ETC_NGINX}
	cp -f  nginx/${SITE} ${SITES_AVAILABLE}
	ln -fs ${SITES_AVAILABLE}/${SITE} ${SITES_ENABLED}/${SITE}

.PHONY : nginx_installed
nginx_installed :
	nginx --version
