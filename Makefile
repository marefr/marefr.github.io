JEKYLL_VERSION = 3.0

.PHONY: deps serve

deps:
	docker run --rm -it \
		--volume="${PWD}:/srv/jekyll" \
		--volume="${PWD}/vendor/bundle:/usr/local/bundle" \
		jekyll/jekyll:${JEKYLL_VERSION} \
		bundle update

serve:
	docker run --rm \
		--volume="${PWD}:/srv/jekyll" \
		--volume="${PWD}/vendor/bundle:/usr/local/bundle" \
		--publish [::1]:4000:4000 \
		jekyll/jekyll:${JEKYLL_VERSION} \
		jekyll serve --drafts
