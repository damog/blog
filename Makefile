posts:
	./chronicle/bin/chronicle \
		--lower-case \
		--verbose \
		--theme copyrighteous \
		--theme-dir chronicle/themes \
		--output ../www/damog.net/blog \
		--recent-tags-first \
		--recent-dates-first \
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
