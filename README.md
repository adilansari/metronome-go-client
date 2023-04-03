# [Metronome](https://docs.metronome.com/api/) Go client
Go client for Metronome generated from its OpenAPI spec

> This is not an official client, and was generated for personal use from their [OpenAPI spec](https://docs.metronome.com/api/).

## Installation

By using this client you'll avoid a lot of boilerplate code to perform all the 
marshalling and unmarshalling into objects when using Metronome HTTP APIs.

Install in your project to have it as a dependency in `go.mod`:
```shell
go get github.com/adilansari/metronome-go-client@latest
```

## Usage

##### Authentication

Metronome requires all HTTP requests to [include a authorization header](https://docs.metronome.com/using-the-api/authorization/)
for authentication:

```shell
GET /v1/... HTTP/1.1
Host: api.metronome.com
Authorization: Bearer MY_TOKEN
```

Instead of adding authorization header to every request when using this go client, you can
simply register a callback as:

```golang
authProvider, err := securityprovider.NewSecurityProviderBearerToken("REPLACE_ME")
if err != nil {
	panic(err)
}

client, err := metronome.NewClient("https://api.metronome.com/v1", metronome.WithRequestEditorFn(authProvider.Intercept))
```

##### Create customer example

Following is a complete example you can try in your project. Replace the `REPLACE_ME` with your
own token generated from Metronome account.

https://github.com/adilansari/metronome-go-client/blob/b78ab12ab45af7cde7c29d300c127c7f94b8500c/examples/create_customer.go

## Requesting updates
- Since this is not official client, the API may be out of date
- Please open an issue in the repo and I'll try to update the client to latest


