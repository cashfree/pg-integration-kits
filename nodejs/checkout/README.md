*****************************************************************************************

# Getting Started
Clone the above repository and extract the nodejs subfolder from inside the pg-integration-kits folder.
Place it in some specific directory (for example in linux - /home/sharoh/cf-nodejs/.

## Pre-requisites

```
1) NodeJS 
```

## How to start
You'll first need to intall nodemon, it is as simple as running `npm install -g nodemon` on your machine. 

Below we describe the NodeJS integration for Cashfree PG. You'll need Cashfree credentials for this setup to work. 
You can access the credentials from the merchant dashboard (API access > credentials) [here](https://test.gocashfree.com/merchant/pg#api-key).

**Step 1**

  - Open the file *app.js*, and update the value of the variable *mode* to "TEST"(for testing) or "PROD"(for production) depending on your environment (line 36).

  - Update the variable *secretKey* with the correct value for the mode you have selected in the *app.js* file (line number 37 and 67).

**Step 2**

  Once you've installed nodemon in your system and updated the file with the correct secretKey values. 
  Run the following commands from the folder where you have the app.js file, this will start your server.
  ```bash
  nodemon --exec npm start
  ```
  - Visit *http://localhost:3000/* in the browser, fill in the details as required, set the returnUrl as *http://localhost:3000/response* and click Submit.

  - Once the payment page loads, enter the following card details for testing purpose. 
  
  ```
  Card Number : 4111 1111 1111 1111
  CVV : 123
  ```
  You can enter any name, month and year for card expiration. For more details around test cards, see [Test Data](https://docs.cashfree.com/docs/resources/#test-data).

**Step 3**

  - Once you've entered the details you will be redirected to the Cashfree PG Simulator page. Here you can simulate either a failed or a successful transaction. You will then be redirected to the *returnUrl*(given in step 2) with the transaction details.

**NOTE :** 

- In the file app.js, please make sure that you are using the correct integration mode. 
- Give a valid returnUrl, since all the transaction details will be sent to this url.
- It is imperative that you process the response correctly (by verifying the signature) to prevent any fraud on your website. 

## Support

For further queries reach us at [techsupport@gocashfree.com](techsupport@gocashfree.com). 

*****************************************************************************************
