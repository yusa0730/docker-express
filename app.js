const express = require('express');
const serverlessExpress = require('aws-serverless-express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Lambda!');
});

const server = serverlessExpress.createServer(app);

exports.handler = (event, context) => {
  return serverlessExpress.proxy(server, event, context);
};
