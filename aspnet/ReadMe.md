*****************************************************************************************

# Getting Started
Clone the above repository and extract the aspnet subfolder from inside the pg-integration-kits folder.

## Pre-requisites

```
1) Visual Studio 

```
## How to start

We follow MVC architecture for the project,make sure you install the MVC component in visual studio.

Below we describe the ASP .NET integration for Cashfree PG. You'll need Cashfree credentials for this setup to work. You can access the credentials from the merchant dashboard (API access > credentials) [here](https://test.gocashfree.com/merchant/pg#api-key).

**Step 1**

  - Open the project in Visual Studio. 

  - Open the file *pgcontroller.cs*(aspnet/PgSim/Controllers/pgcontroller.cs), and update the value of the variable *mode* to "TEST"(for testing) or "PROD"(for production) depending on your environment.

  - Update the variable *secretKey* with the correct value for the mode you have selected in the *HandleRequest* and *HandleResponse* methods.

**Step 2**

  Once you have completed the above changes you need to start the .NET application.

  - Deploy it through IIS Express in Visual Studio.

  - An url (ex. : *http://127.0.0.1:54083/Index* ) will open in the browser, fill in the details as required, set the returnUrl as *http://127.0.0.1:54083/HandleResponse* (change the port number to your port) and click Submit.

  - Once the payment page loads, enter the following card details for testing purpose. 
  
  ```
  Card Number : 4111 1111 1111 1111
  CVV : 123
  ```
  You can enter any name, month and year for card expiration. For more details around test cards, see [Test Data](https://docs.cashfree.com/docs/resources/#test-data).

**Step 3**

  - Once you've entered the details you will be redirected to the Cashfree PG Simulator page. Here you can simulate either a failed or a successful transaction. You will then be redirected to the *returnUrl*(given in step 2) with the transaction details.

**NOTE :** 

- In the file *pgcontroller.cs*, please make sure that you are using the correct integration mode. 
- Give a valid returnUrl, since all the transaction details will be sent to it.
- It is imperative that you process the response correctly to prevent any fraud on your website. 

## More Details

To start integrating in production you just need to change the *mode* in *pgcontroller.cs* to "PROD" and get the production credentials from (API access > credentials) [here](https://merchant.cashfree.com/merchant/pg#api-key). Also update the variable *secretkey* in *pgcontroller.cs* file.

## Found a bug?

Report it at [https://github.com/cashfree/pg-integration-kits/issues](https://github.com/cashfree/pg-integration-kits/issues)

## Support

For further queries reach us at [techsupport@gocashfree.com](techsupport@gocashfree.com). 

*****************************************************************************************
