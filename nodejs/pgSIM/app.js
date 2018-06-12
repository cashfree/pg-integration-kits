var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var app = express();
var crypto    = require('crypto');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());   
app.use('/', indexRouter);

app.post('/request',function(req, res, next){

	var postData = {
		"appId" : req.body.appId,
		"orderId" : req.body.orderId,
		"orderAmount" : req.body.orderAmount,
		"orderCurrency" : req.body.orderCurrency,
		"orderNote" : req.body.orderNote,
		'customerName' : req.body.customerName,
		"customerEmail" : req.body.customerEmail,
		"customerPhone" : req.body.customerPhone,
		"returnUrl" : req.body.returnUrl,
		"notifyUrl" : req.body.notifyUrl
	},
	mode = "TEST",
	secretKey = "<ENTER_SECRET_KEY_HERE>",
	sortedkeys = Object.keys(postData),
	url="",
	signatureData = "";
	sortedkeys.sort();
	for (var i = 0; i < sortedkeys.length; i++) {
		k = sortedkeys[i];
		signatureData += k + postData[k];
	}
	var signature = crypto.createHmac('sha256',secretKey).update(signatureData).digest('base64');
	postData['signature'] = signature;
	if (mode == "PROD") {
	  url = "https://www.cashfree.com/checkout/post/submit";
	} else {
	  url = "https://test.cashfree.com/billpay/checkout/post/submit";
	}
	res.render('request',{postData : JSON.stringify(postData),url : url});
});

app.post('/response',function(req, res, next){

	var postData = {
	  "orderId" : req.body.orderId,
	  "orderAmount" : req.body.orderAmount,
	  "referenceId" : req.body.referenceId,
	  "txStatus" : req.body.txStatus,
	  "paymentMode" : req.body.paymentMode,
	  "txMsg" : req.body.txMsg,
	  "txTime" : req.body.txTime
	 },
	secretKey = "<ENTER_SECRET_KEY_HERE>",

	signatureData = "";
	for (var key in postData) {
		signatureData +=  postData[key];
	}
	var computedsignature = crypto.createHmac('sha256',secretKey).update(signatureData).digest('base64');
	postData['signature'] = req.body.signature;
	postData['computedsignature'] = computedsignature;
	res.render('response',{postData : JSON.stringify(postData)});
});


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
