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
