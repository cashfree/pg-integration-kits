var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Cashfree PG simulator' });
});

// router.get('/request', function(req, res, next) {
//   res.render('request');
// });
module.exports = router;
