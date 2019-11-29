### How To Crawl Category Data from Product Id

`root/crawl/crawl/spiders/` 폴더에 product_id를 key로 가지는 json을 `inddex.json` 으로 저장합니다.

```
// crawl/craw/spiders/index.json
{"861": "", "7077": "", "6840": "", "498": ""} 
```

```
// project_root
pip install scrapy
cd crawl/crawl
scrapy crawl category
```

결과가 `root/crawl/crawl/result.json` 에 저장됩니다

```
// craw/crawl/result/index.json
{"861": 28, "7078": 32, "6840": 27, "498": 37}
```

카테고리이름 (str) - 카테고리id(int)는 `root/crawl/crawl/spiders/category.py` 에서 확인할 수 있습니다