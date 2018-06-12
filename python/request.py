#!/usr/bin/python
# -*- coding: latin-1 -*-
from flask import Flask, render_template
from flask import request
import hashlib
import hmac
import base64

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('start.html')

# secretKey = "<ENTER_YOUR_SECRETKEY_HERE>"
secretKey = "d1cb82a1aff501aa64aa0a608d2aa8cc4e9fcc1f"
@app.route('/request', methods=["POST"])
def handlerequest():
  mode = "TEST" # <-------Change to TEST for test server, PROD for production
  postData = {
      "appId" : request.form['appId'], 
      "orderId" : request.form['orderId'], 
      "orderAmount" : request.form['orderAmount'], 
      "orderCurrency" : request.form['orderCurrency'], 
      "orderNote" : request.form['orderNote'], 
      "customerName" : request.form['customerName'], 
      "customerPhone" : request.form['customerPhone'], 
      "customerEmail" : request.form['customerEmail'], 
      "returnUrl" : request.form['returnUrl'], 
      "notifyUrl" : request.form['notifyUrl']
  }
  sortedKeys = sorted(postData)
  signatureData = ""
  for key in sortedKeys:
    signatureData += key+postData[key]
  message = signatureData.encode('utf-8')
  #get secret key from your config
  secret = secretKey.encode('utf-8')
  signature = base64.b64encode(hmac.new(secret,message,digestmod=hashlib.sha256).digest()).decode("utf-8")
  if mode == 'PROD': 
    url = "https://www.cashfree.com/checkout/post/submit"
  else: 
    url = "https://test.cashfree.com/billpay/checkout/post/submit"
  return render_template('request.html', postData = postData,signature = signature,url = url)

@app.route('/response', methods=["GET","POST"])
def handleresponse():

  postData = {
    "orderId" : request.form['orderId'], 
    "orderAmount" : request.form['orderAmount'], 
    "referenceId" : request.form['referenceId'], 
    "txStatus" : request.form['txStatus'], 
    "paymentMode" : request.form['paymentMode'], 
    "txMsg" : request.form['txMsg'], 
    "signature" : request.form['signature'], 
    "txTime" : request.form['txTime']
   }

  signatureData = ""
  signatureData = postData['orderId'] + postData['orderAmount'] + postData['referenceId'] + postData['txStatus'] + postData['paymentMode'] + postData['txMsg'] + postData['txTime']

  message = signatureData.encode('utf-8')
  # get secret key from your config
  secret = secretKey.encode('utf-8')
  computedsignature = base64.b64encode(hmac.new(secret,message,digestmod=hashlib.sha256).digest()).decode('utf-8')   
  return render_template('response.html', postData = postData,computedsignature = computedsignature)

if __name__ == '__main__':
  app.run("",5000,debug='true')
