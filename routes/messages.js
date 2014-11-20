var express = require('express');
var router = express.Router();

var child_process = require('child_process');

/**
 *
 */
router.get('/', function(req, res) {
  res.render("messages");
});

/**
 *
 */
router.post('/', function(req, res) {

  var file = 'bin/talk.sh';

  var args = [
    req.body['address'],
    req.body['content']
  ];
  child_process.execFile(file, args, function() {

  });
});

module.exports = router;
