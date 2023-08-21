const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  let filePath = path.join(__dirname, req.url);

  // If the requested path is a directory, append 'index.html'
  if (fs.statSync(filePath).isDirectory()) {
    filePath = path.join(filePath, 'index.html');
  }

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('File not found');
    } else {
      let contentType = 'text/html';

      if (filePath.endsWith('.css')) {
        contentType = 'text/css';
      } else if (filePath.endsWith('.js')) {
        contentType = 'application/javascript';
      }

      res.writeHead(200, { 'Content-Type': contentType });
      res.end(data);
    }
  });
});

const PORT = 3000;

server.listen(PORT, () => {
  console.log(`Server is running at http://127.0.0.1:${PORT}`);
});
