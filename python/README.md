*****************************************************************************************

# Getting Started
Clone the above repository and extract the python subfolder from inside the pg-integration-kits folder.
Place it in some specific directory (for example in linux - /home/sharoh/cf-python/, windows users can also place the directory in any folder like C:\Users\sharoh\cf-python). 

## Pre-requisites

```
1) Flask (http://flask.pocoo.org/)
2) Python

```

## How to start
You'll first need to intall Flask, it is as simple as running `pip install flask` on your machine. 

Below we describe the Python integration for Cashfree PG. You'll need Cashfree credentials for this setup to work. You can access the credentials from the merchant dashboard (API access > credentials) [here](https://test.gocashfree.com/merchant/pg#api-key).

**Step 1**

  - Open the file *request.py*, and update the value of the variable *mode* to "TEST"(for testing) or "PROD"(for production) depending on your environment (line 19).

  - Update the variable *secretKey* with the correct value for the mode you have selected in the *request.py* file.

**Step 2**

  Once you have installed flask in your system and completed the above changes you need to start the python application.
  Run the following commands from the folder where you have the request.py file.  
  ```bash
  export FLASK_APP=request.py
  flask run
  ```
  - Visit *http://127.0.0.1:5000/* in the browser, fill in the details as required, set the returnUrl as *http://127.0.0.1:5000/response* and click Submit.

  - Once the payment page loads, enter the following card details for testing purpose. 
  
  ```
  Card Number : 4111 1111 1111 1111
  CVV : 123
  ```
  You can enter any name, month and year for card expiration. For more details around test cards, see [Test Data](https://docs.cashfree.com/docs/resources/#test-data).

**Step 3**

  - Once you've entered the details you will be redirected to the Cashfree PG Simulator page. Here you can simulate either a failed or a successful transaction. You will then be redirected to the *returnUrl*(given in step 2) with the transaction details.

**NOTE :** 

- In the file request.py, please make sure that you are using the correct integration mode. 
- Give a valid returnUrl, since all the transaction details will be sent to it.
- It is imperative that you process the response correctly to prevent any fraud on your website. 

## More Details

To start integrating in production you just need to change the *mode* in *request.py* to "PROD" and get the production credentials from (API access > credentials) [here](https://merchant.cashfree.com/merchant/pg#api-key). Also update the variable *secretkey* in *request.py* file.


## Support

For further queries reach us at [techsupport@gocashfree.com](techsupport@gocashfree.com). 

*****************************************************************************************
