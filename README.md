
## Supported Games

- 天堂M
- 天堂W
- 天堂 2 M
- 明日方舟
- 最強蝸牛
- 天涯明月刀

## Env vars

```
API_HOST=
```

## TODOs

- [] We should extract http request logic to a collector service. This service can be used accross different collector extensions.
- [] Create a globally accessible dictionary to record collected product information. This dictionary helps to dedupe duplicated request to collect API.

Upon launch inappcollect extension in game, we should retrieve a list of collected item of that game. The reason being that 'productsRequest:didReceiveResponse' is triggered multiple times to retrieve product info regardless of pressing the 'confirm purchase button'. This causes unecessary http request to BE for check whether the product info has been collected or not.
