'use strict';

const http = require('http');
const FB = require('fb');
FB.options({version: 'v2.11'});


function persistFBUserData(token) {   
	FB.setAccessToken(token);
	
	FB.api(
		'me', 
		{ fields: ['id', 'name', 'age_range', 'birthday', 'email'], access_token: token }, 
		function (res) {
	    	console.log(res);
		}
	);	
}

const routing = {
    '/api/token/*': (client, par) => persistFBUserData(par[0])
};

const types = {
  object: o => JSON.stringify(o),
  string: s => s,
  number: n => n + '',
  undefined: () => 'not found',
  function: (fn, par, client) => fn(client, par)
};

const matching = [];
for (const key in routing) {
  if (key.includes('*')) {
    const rx = new RegExp(key.replace('*', '(.*)'));
    const route = routing[key];
    matching.push([rx, route]);
    delete routing[key];
  }
}



function router(client) {
  let rx, par;
  let route = routing[client.req.url];
  if (route === undefined) {
    for (let i = 0, len = matching.length; i < len; i++) {
      rx = matching[i];
      par = client.req.url.match(rx[0]);
      if (par) {
        par.shift();
        route = rx[1];
        break;
      }
    }
  }
  const type = typeof(route);
  const renderer = types[type];
  return renderer(route, par, client);
}

http.createServer((req, res) => {
  res.end(router({ req, res }) + '');
}).listen(80);