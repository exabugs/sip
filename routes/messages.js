var express = require('express');
var router = express.Router();

var child_process = require('child_process');

/**
 *
 */
router.get('/', function (req, res) {
  res.render("messages");
});

/**
 *
 */
router.post('/', function (req, res) {

  var file = 'bin/talk.sh';

  var address = req.body['address'];
  var content = req.body['content'];

  content = content.replace(/[\r\n]/g, ' ');

  child_process.execFile(file, [address, content], function (err) {
    res.send(err ? 500 : 200);
  });
});

module.exports = router;
