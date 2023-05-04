API_DIR=api
VER=v1
FILE_NAME=openapi.json
API_FILE_PATH=${API_DIR}/${VER}/${FILE_NAME}

update_api:
	TMP_FILE=$(shell mktemp) && \
	wget https://api.metronome.com/v1/openapi.json -O $${TMP_FILE} && \
	jq . "$${TMP_FILE}" > ${API_FILE_PATH}

fix:
	./scripts/fix_openapi.sh ${API_FILE_PATH}

generate: 
	oapi-codegen -package metronome -generate "client, types, spec" \
	${API_FILE_PATH} > metronome.gen.go

publish:
	new_tag="$(version)" && \
	if [ -z $${new_tag} ] ; then \
		echo "version required. Usage: make publish version=<new version>" ; \
		exit 1 ; \
	fi && \
	tags="$(shell git tag)" && \
	if [[ ! "$${tags[*]}" =~ "$${new_tag}" ]] ; then \
		echo "tag does not exist" ; \
		exit 1 ; \
	fi && \
	publishCmd="GOPROXY=proxy.golang.org go list -m github.com/adilansari/metronome-go-client@$${new_tag}" && \
	echo $${publishCmd}