
*****************************************************************************************

# Getting Started
Clone the above repository and extract the java subfolder from inside the pg-integration-kits folder.

Copy the contents of the *java* subfolder and move then to a folder called *cashfree*.

```
git clone https://github.com/cashfree/pg-integration-kits.git
mkdir ~/cashfree
cp -r pg-integration-kits/java ~/cashfree/
```
We then move this *cashfree* folder to the webapps folder in our tomcat. Let's assume that the tomcat root directory is  /usr/local/apache-tomcat-9.0.10 (the copied directory should then look like  /usr/local/apache-tomcat-9.0.10/cashfree) 

```
export TOMCAT_HOME=/usr/local/apache-tomcat-9.0.10/
mkdir $TOMCAT_HOME/webapps/cashfree
mv ~/cashfree/* $TOMCAT_HOME/webapps/cashfree/
```

## Pre-requisites

```
1)Tomcat (You can download from [here](https://tomcat.apache.org/download-90.cgi) 
2)Java

```

## How to start

Below we describe the JAVA integration for Cashfree PG. You'll need Cashfree credentials for this setup to work. You can access the credentials from the merchant dashboard (API access > credentials) [here](https://test.gocashfree.com/merchant/pg#api-key).

**Step 1**

  - Update the variable *$secretKey* with the value which you accessed from the merchant dashboard in the *request.jsp* file

**Step 2**
  - Start your tomcat server 
  ```
  $TOMCAT_HOME/bin/startup.sh
  ```
  - Visit *localhost:8080/cashfree/start.html* in your browser, fill in the details as required, set the returnUrl as *http://localhost:8080/response.jsp* and click Submit.

  - Once the payment page loads, enter the following card details for testing purpose. 
  
  ```
  Card Number : 4111 1111 1111 1111
  CVV : 123
  ```
  You can enter any name, month and year for card expiration. For more details around test cards, see [Test Data](https://docs.cashfree.com/docs/resources/#test-data).

**Step 3**

  - Once you've entered the details you will be redirected to the Cashfree PG Simulator page. Here you can simulate either a failed or a successful transaction. You will then be redirected to the *returnUrl*(given in step 2) with the transaction details.

**NOTE :** 

- Give a valid returnUrl, since all the transaction details will be sent to it.
- It is imperative that you process the response correctly to prevent any fraud on your website. 

## More Details

To start integrating in production you just need to change to prod credentials, these can be accessed from (API access > credentials) [here](https://merchant.cashfree.com/merchant/pg#api-key). Also update the variable *$secretkey* in *request.jsp* and *response.jsp* files.


## Support

For further queries reach us at [techsupport@gocashfree.com](techsupport@gocashfree.com). 

*****************************************************************************************
