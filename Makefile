MAKEFLAGS=--no-builtin-rules --no-builtin-variables --always-make
ROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

vendor:
	yarn install
	
gen:
	npx apollo client:codegen ./WebRTC/GraphQL/API.swift --target=swift --queries=./WebRTC/GraphQL/app.graphql --localSchemaFile=./WebRTC/GraphQL/schema.graphql --namespace=GraphQL
