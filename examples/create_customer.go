package main

import (
	"context"
	"fmt"
	"net/http"

	"github.com/deepmap/oapi-codegen/pkg/securityprovider"

	"github.com/adilansari/metronome-go-client"
)

func main() {
	// API key based authentication. Add your metronome auth token here.
	// Learn more about auth: https://docs.metronome.com/using-the-api/authorization/
	authProvider, err := securityprovider.NewSecurityProviderBearerToken("REPLACE_ME")
	if err != nil {
		panic(err)
	}

	// Client will be used to perform all operations on metronome.
	// Auth provider generated above will implicitly add an authorization token to all requests.
	client, err := metronome.NewClientWithResponses(
		"https://api.metronome.com/v1",
		metronome.WithRequestEditorFn(authProvider.Intercept),
	)
	if err != nil {
		panic(err)
	}

	// JSON request for CreateCustomer
	createCustomerBody := metronome.CreateCustomerJSONRequestBody{
		IngestAliases: &[]string{"my_customer_alias"},
		Name:          "my_customer_id",
	}

	// HTTP POST call to "/customers" endpoint
	resp, err := client.CreateCustomerWithResponse(context.TODO(), createCustomerBody)
	if err != nil {
		panic(err)
	}

	// Checking if request succeeded
	if resp.StatusCode() != http.StatusOK {
		panic(fmt.Errorf("metronome request failed: %s", resp.Body))
	}

	// Response available as a struct without explicit parsing
	customer := resp.JSON200.Data

	fmt.Printf("'id' of created customer: %s\n", customer.Id)
	fmt.Printf("'name' of created customer: %s\n", customer.Name)
	fmt.Printf("'aliases' for the created customer: %s\n", customer.IngestAliases)
}

// Sample output:
// 'id' of created customer: 1eeb3160-1d1a-40dc-9571-1a65fefbc975
// 'name' of created customer: my_customer_id
// 'aliases' for the created customer: [my_customer_alias]
