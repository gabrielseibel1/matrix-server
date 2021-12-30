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
	find . -type f -exec sed -i 's/.md/.html/g' {} \; # replace md references with html ones
	mkdir -p ${CONTENT_ROOT}/docs
	mv ${INDEX_HTML} ${CONTENT_ROOT}/${INDEX_HTML}
	mv ${USAGE_HTML} ${CONTENT_ROOT}/${USAGE_HTML}
	mv ${IMAGES}     ${CONTENT_ROOT}/${IMAGES}
	mv nginx/nginx.conf /etc/nginx/nginx.conf
	mv nginx/pimatrixconduit.xyz ${SITE_AVAILABLE}
	rm ${SITE_ENABLED} ${CONTENT_ROOT}/${STICKERS} || true # fail silently
	ln -s ${SITE_AVAILABLE} ${SITE_ENABLED}
	ln -s ${STICKERS} ${CONTENT_ROOT}/${STICKERS}
