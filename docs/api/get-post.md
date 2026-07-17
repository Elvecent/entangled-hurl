## Get a post

``` { .hurl file=tests/get-post.hurl #get-post}
GET https://jsonplaceholder.typicode.com/posts/{{post_id}}
HTTP 200
[Asserts]
<<application-json-header-assert>>
jsonpath "$.id" == {{post_id}}
jsonpath "$.title" exists
```

Run it:

``` { .bash .task }
#| description: "run get-post"
#| requires: "tests/get-post.hurl"
#| creates: ["tests/results/get-post.txt", "tests/results/get-post.curl"]
#| collect: "test"
hurl --variable post_id=1 --curl tests/results/get-post.curl \
  tests/get-post.hurl > tests/results/get-post.txt 2>&1
```
