var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/1', function(req, res, next) {
  res.render('example1');
});

router.get('/2', function(req, res, next) {
  res.render('example2');
});

router.get('/3/login', function(req, res, next) {
  res.render('example3-login');
});

router.get('/3', function(req, res, next) {
  res.render('example3-registration');
});

router.get('/3/registration', function(req, res, next) {
  res.render('example3-registration');
});

router.get('/4', function(req, res, next) {
  res.render('example4');
});

router.get('/5/login', function(req, res, next) {
  res.render('example5-login');
});

router.get('/5', function(req, res, next) {
  res.render('example5-registration');
});

router.get('/5/registration', function(req, res, next) {
  res.render('example5-registration');
});

module.exports = router;
