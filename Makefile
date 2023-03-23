API_DIR=api
V=v1

generate: 
	oapi-codegen -package metronome -generate "client, types, spec" \
	${API_DIR}/${V}/openapi.json > metronome.gen.go
