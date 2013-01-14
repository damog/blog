posts:
	./chronicle/bin/chronicle \
		--lower-case \
		--verbose \
		--theme copyrighteous \
		--theme-dir chronicle/themes \
		--output ../www/damog.net/blog \
		--no-tags \
		--config config.txt

sync:
	rsync \
		-r \
		-a \
		-v \
		-e ssh \
		--delete \
		../www/damog.net	\
		josephine:www/
