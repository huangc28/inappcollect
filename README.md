Upon launch inappcollect extension in game, we should retrieve a list of collected item of that game. The reason being that 'productsRequest:didReceiveResponse' is triggered multiple times to retrieve product info regardless of pressing the 'confirm purchase button'. This causes unecessary http request to BE for check whether the product info has been collected or not.

## Env vars

```
API_HOST=
```
