# Url Shortener Code Test

## Usage instructions

Adding new entries can be done using the below interface;
``` sh
➜ curl localhost:3000 -H "Accept: application/json" -H "Content-type: application/json" -XPOST -d '{ "url": "http://www.farmdrop.com" }'
{"short_url":"toj893","url":"http://www.farmdrop.com"}%

➜ curl localhost:3000 -H "Accept: application/json" -H "Content-type: application/json" -XPOST -d '{ "url": "http://www.google.com" }'
{"short_url":"qgc327","url":"http://www.google.com"}%
```

And curling the short url provided will return the redirect
``` sh
➜ curl -v localhost:3000/toj893
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 3000 (#0)
> GET /toj893 HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 302 Found
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Permitted-Cross-Domain-Policies: none
< Referrer-Policy: strict-origin-when-cross-origin
< Location: http://www.farmdrop.com
< Content-Type: text/html; charset=utf-8
< Cache-Control: no-cache
< X-Request-Id: f8d9be52-6883-42d8-9d17-9b2caec0a207
< X-Runtime: 0.001942
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
<html><body>You are being <a href="http://www.farmdrop.com">redirected</a>.</body></html>* Closing connection 0
```

You can also list all the short codes by calling a get on the root url
``` sh
➜ curl localhost:3000 -H "Accept: application/json" -H "Content-type: application/json"
[{"short_url":"toj893","url":"http://www.farmdrop.com"},{"short_url":"qgc327","url":"http://www.google.com"}]%
```

### Datastore

I considered doing this via Redis rather than just an Array assigned to a constant but figured that might hit up against being technically a database and therefore be breaking the rules. It's certainly more than is needed here but it would certainly be a nicer method.

### Docker

I'd steer clear of this, I had it working initially but there seems to be problems with how yarn works and docker. I've tried updating this a few different ways and it seems to work on a clean build and not after. On reflection given I decided to focus on the API rather than the frontend I'd probably spin this up as a Rails API project in future instead and avoid the headache of fighting with yarn. Otherwise I'd need to do a deeper dive on this as I've never run into this problem before with rails and docker.

## Original content below

---

Without using an external database, we'd like you to create a URL shortening
service. The URLs do not need to persist between restarts, but should be
shareable between different clients while the server is running.

- There should be an endpoint that responds to `POST` with a json body
  containing a URL, which responds with a JSON repsonse of the short url and
  the orignal URL, as in the following curl example:

```
curl localhost:4000 -XPOST -d '{ "url": "http://www.farmdrop.com" }'
{ "short_url": "/abc123", "url": "http://www.farmdrop.com" }
```


- When you send a GET request to a previously returned URL, it should redirect
  to the POSTed URL, as shown in the following curl example:

```
curl -v localhost:4000/abc123
...
< HTTP/1.1 301 Moved Permanently
...
< Location: http://www.farmdrop.com
...
{ "url": "http://www.farmdrop.com" }
```

Use whatever languages and frameworks you are comfortable with. Don't worry
about getting the whole thing working flawlessly, this is more to see how you
structure a program. Please don't spend more than a few hours on it.

Bonus points:

- I often forget to type "http://" at the start of a URL. It would be nice if
  this was handled by the application (frontend or backend is up to you).
- We like to see how you approach the problem, so a few git commits with a
  clear message about what you're doing are better than one git commit with
  everything in it.
- We like tests. We don't expect a full test suite, but some tests would be
  nice to see. Its up to you whether thats integration, unit or some other
  level of testing.
- We'd be very happy to see a Dockerfile to run the project. This by no means a
  requirement, so don't go reading the Docker docs if you've never worked with
  it.
- If you'd like to show off your frontend skills, you could create a simple
  frontend that can create and display shortened URLs without reloading the
  page.

## Submission

Please clone this repository, write some code and update this README with a
guide of how to run it.

Either send us a link to the repository on somewhere like github or bitbucket
(bitbucket has free private repositories) or send us a git bundle.

    git bundle create yournamehere-url-shortener-test.bundle master

And send us the resulting `yournamehere-url-shortener-test.bundle` file.

This `.bundle` file can be cloned using:

    git bundle clone bundle-filename.bundle -b master directory-name
