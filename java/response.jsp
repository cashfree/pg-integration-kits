
<%@ page import ="java.io.*,java.nio.*,java.util.*,javax.crypto.spec.SecretKeySpec,javax.crypto.Mac,javax.crypto.SecretKey" %>
<%@ page import="java.lang.*,java.security.*" %>


<!DOCTYPE html>
<html>
<head>
	<title>Cashfree - PG Response Details</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<h1 align="center">PG Response</h1>	

	<%  
	  String orderId = request.getParameter("orderId");
	  String orderAmount= request.getParameter("orderAmount");
	  String referenceId = request.getParameter("referenceId");
	  String txStatus = request.getParameter("txStatus");
	  String paymentMode = request.getParameter("paymentMode");
	  String txMsg = request.getParameter("txMsg");
	  String txTime = request.getParameter("txTime");
	  String signature = request.getParameter("signature");

// LinkedHashMap<String, String> postData = new LinkedHashMap<String, String>();

// 	postData.put("orderId", orderId);
// 	postData.put("orderAmount", orderAmount);
// 	postData.put("referenceId", referenceId);
// 	postData.put("txStatus", txStatus);
// 	postData.put("paymentMode", paymentMode);
// 	postData.put("txMsg", txMsg);
// 	postData.put("txTime", txTime);
// 	Set<String> keys = postData.keySet();
// 	for (String key : keys) {
// 	    data = data + postData.get(key);
// 	}
    String data = orderId + orderAmount + referenceId + txStatus + paymentMode + txMsg + txTime;

	String secretKey = "2279c0ffb9550ad0f9e0652741c8d06a49409517"; // Get secret key from config;
	Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
	SecretKeySpec secret_key_spec = new
	SecretKeySpec(secretKey.getBytes(),"HmacSHA256");
	sha256_HMAC.init(secret_key_spec);

	String computedsignature = Base64.getEncoder().encodeToString(sha256_HMAC.doFinal(data.getBytes()));
	
 
	if (signature.equals(computedsignature)){
	%>
	<div class="container"> 
	<div class="panel panel-success">
	  <div class="panel-heading">Signature Verification Successful</div>
	  <div class="panel-body">
	 		<table class="table table-hover">
			    <tbody>
			      <tr>
			        <td>Order ID</td>
			        <td><%= orderId %></td>
			      </tr>
			      <tr>
			        <td>Order Amount</td>
			        <td><%= orderAmount %></td>
			      </tr>
			      <tr>
			        <td>Reference ID</td>
			        <td><%= referenceId %></td>
			      </tr>
			      <tr>
			        <td>Transaction Status</td>
			        <td><%= txStatus %></td>
			      </tr>
			      <tr>
			        <td>Payment Mode </td>
			        <td><%= paymentMode %></td>
			      </tr>
			      <tr>
			        <td>Message</td>
			        <td><%= txMsg %></td>
			      </tr>
			      <tr>
			        <td>Transaction Time</td>
			        <td><%= txTime %></td>
			      </tr>
			    </tbody>
			</table>
		<!-- </div> -->

	   </div>
	</div>
	</div>
	 <%   
	  	}else{
	 
	 %>
	<div class="container"> 
	<div class="panel panel-danger">
	  <div class="panel-heading">Signature Verification failed</div>
	  <div class="panel-body">
	  	<!-- <div class="container"> -->
	 		<table class="table table-hover">
			    <tbody>
			      <tr>
			        <td>Order ID</td>
			        <td><%= orderId %></td>
			      </tr>
			      <tr>
			        <td>Order Amount</td>
			        <td><%= orderAmount %></td>
			      </tr>
			      <tr>
			        <td>Reference ID</td>
			        <td><%= referenceId %></td>
			      </tr>
			      <tr>
			        <td>Transaction Status</td>
			        <td><%= txStatus %></td>
			      </tr>
			      <tr>
			        <td>Payment Mode </td>
			        <td><%= paymentMode %></td>
			      </tr>
			      <tr>
			        <td>Message</td>
			        <td><%= txMsg %></td>
			      </tr>
			      <tr>
			        <td>Transaction Time</td>
			        <td><%= txTime %></td>
			      </tr>
			    </tbody>
			</table>
		<!-- </div> -->
	  </div>	
	</div>	
	</div>
	
	<%	
	 	}
	 %>

</body>
</html>



