class PgformController < ApplicationController
require 'openssl'
require 'base64'
skip_before_action :verify_authenticity_token

  def index
  end
  
  def HandleRequest
  	mode = "TEST" 
    @postData = {
      "appId" => params[:appId],
      "orderId" => params[:orderId],
      "orderAmount" => params[:orderAmount],
      "orderCurrency" => params[:orderCurrency],
      "orderNote" => params[:orderNote],
      "customerName" => params[:customerName],
      "customerPhone" => params[:customerPhone],
      "customerEmail" => params[:customerEmail],
      "returnUrl" => params[:returnUrl],
      "notifyUrl" => params[:notifyUrl]
  	}
  	@signatureData =""
  	@secretKey = "ENTER_YOUR_SECRET_KEY_HERE"
  	@postData.sort.map do |key,value|
  		@signatureData += key + value
  	end
 	if mode == "PROD"
 		@url = "https://www.cashfree.com/checkout/post/submit"
 	else
 		@url = "https://test.cashfree.com/billpay/checkout/post/submit"
 	end
 	@signature = Base64.encode64(OpenSSL::HMAC.digest('sha256', @secretKey, @signatureData)).strip()
  end


  def HandleResponse
  	@postData = {
    "orderId" => params[:'orderId'], 
    "orderAmount" => params[:'orderAmount'], 
    "referenceId" => params[:'referenceId'], 
    "txStatus" => params[:'txStatus'], 
    "paymentMode" => params[:'paymentMode'], 
    "txMsg" => params[:'txMsg'], 
    "txTime" => params[:'txTime']
   	}
  	@secretKey = "ENTER_YOUR_SECRET_KEY_HERE"
    @signature = params[:'signature']
   	@signatureData = ""
   	@postData.each do |key,value|
  		@signatureData += value
  	end
 	@computedsignature = Base64.encode64(OpenSSL::HMAC.digest('sha256', @secretKey, @signatureData)).strip()
  end	
end
