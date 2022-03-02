CONTENT_ROOT = /var/www/pimatrixconduit.xyz
ETC_NGINX = /etc/nginx
SITE = pimatrixconduit.xyz
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
	test ! -d ${CONTENT_ROOT} && mkdir -p ${CONTENT_ROOT} || true
	cp -rf --parents \
		${INDEX_HTML} \
		${USAGE_HTML} \
    		${IMAGES} \
    		${STICKERS} \
    		${CONTENT_ROOT}
	cp -i  nginx/nginx.conf ${ETC_NGINX}/
	cp -f  nginx/${SITE} ${ETC_NGINX}/sites-enabled/

.PHONY : nginx_installed
nginx_installed :
	nginx -v
