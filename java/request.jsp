
<%@ page import ="java.io.*,java.nio.*,java.util.*,javax.crypto.spec.SecretKeySpec,javax.crypto.Mac,javax.crypto.SecretKey" %>
<%@ page import="java.lang.*,java.security.*" %>

<html>
<head>
  <title>Cashfree - PG request</title>
</head>
<body onload="document.frm1.submit()">
<%
  String appId = request.getParameter("appId");
  String orderId = request.getParameter("orderId");
  String orderAmount= request.getParameter("orderAmount");
  String orderCurrency = request.getParameter("orderCurrency");
  String orderNote = request.getParameter("orderNote");
  String customerName = request.getParameter("customerName");
  String customerEmail = request.getParameter("customerEmail");
  String customerPhone = request.getParameter("customerPhone");
  String returnUrl = request.getParameter("returnUrl");
  String notifyUrl = request.getParameter("notifyUrl");
  String secretKey = "2279c0ffb9550ad0f9e0652741c8d06a49409517";

Map<String, String> postData = new HashMap<String, String>();
  postData.put("appId", appId);
  postData.put("orderId", orderId);
  postData.put("orderAmount", orderAmount);
  postData.put("orderCurrency", orderCurrency);
  postData.put("orderNote", orderNote);
  postData.put("customerName", customerName);
  postData.put("customerEmail", customerEmail);
  postData.put("customerPhone", customerPhone);
  postData.put("returnUrl",returnUrl);
  postData.put("notifyUrl", notifyUrl);
  String data = "";
  SortedSet<String> keys = new TreeSet<String>(postData.keySet());
  for (String key : keys) {
      data = data + key + postData.get(key);
  }
  Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
  SecretKeySpec secret_key_spec = new SecretKeySpec(secretKey.getBytes(),"HmacSHA256");
  sha256_HMAC.init(secret_key_spec);
  String signature = Base64.getEncoder().encodeToString(sha256_HMAC.doFinal(data.getBytes()));
%>

  <form action="https://test.cashfree.com/billpay/checkout/post/submit" name="frm1" method="post">
      <p>Please wait.......</p>
      <input type="text" name="signature" value="<%= signature %>"/>
      <input type="hidden" name="orderNote" value="<%=orderNote%>"/>
      <input type="hidden" name="orderCurrency" value="<%=orderCurrency%>"/>
      <input type="hidden" name="customerName" value="<%=customerName%>"/>
      <input type="hidden" name="customerEmail" value="<%=customerEmail%>"/>
      <input type="hidden" name="customerPhone" value="<%=customerPhone%>"/>
      <input type="hidden" name="orderAmount" value="<%=orderAmount%>"/>
      <input type ="hidden" name="notifyUrl" value="<%=notifyUrl%>"/>
      <input type ="hidden" name="returnUrl" value="<%=returnUrl%>"/>
      <input type="hidden" name="appId" value="<%=appId%>"/>
      <input type="hidden" name="orderId" value="<%=orderId%>"/>
  </form>
  
</body>
</html> 