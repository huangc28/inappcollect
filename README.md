
## Supported Games

- 天堂M
- 天堂W
- 天堂 2 M
- 明日方舟
- 最強蝸牛
- 天涯明月刀
- 哈利波特
- 楓之谷R
- 放置英雄
- 伊蘇 6 (Extract to an independent tweak)
- 三國志 霸道

## Extra framework 問題

Some games implement their payment program logic in framework package. In this case, We'll need to provide the framwork package to Theos at path `$THEOS/lib/` and specify framework path in `Makefile` to hook to class method properly for those games.

**Makefile**

```
inappcollect_EXTRA_FRAMEWORKS = UnityFramework_twysios
inappcollect_FILES = Tweak.xm
```

However, the above approach may cause problem to those game hooks that don't need framework. Thus, those games with framework should be extracted to independent tweak.



## TODOs

- [x] We should extract http request logic to a collector service. This service can be used accross different collector extensions.
- [] Create a globally accessible dictionary to record collected product information. This dictionary helps to filter out duplicated request to collect API.
- [] 伊蘇 6 要是採集成功 / 失敗的 popup 點擊的太慢，"交易進行中的" model 會一直存在不會消失導致畫面點擊不到. 這個要修掉

Upon launch inappcollect extension in game, we should retrieve a list of collected item of that game. The reason being that 'productsRequest:didReceiveResponse' is triggered multiple times to retrieve product info regardless of pressing the 'confirm purchase button'. This causes unecessary http request to BE for check whether the product info has been collected or not.
