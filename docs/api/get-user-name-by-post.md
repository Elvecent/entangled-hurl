## Get a user's name from post id

``` { .hurl file=tests/get-user-name-by-post.hurl }
<<get-post>>
[Captures]
user_id: jsonpath "$.userId"
<<get-user>>

```

``` { .bash .task }
#| description: "run get-user-name-by-post"
#| requires: "tests/get-user-name-by-post.hurl"
#| creates: ["tests/results/get-user-name-by-post.txt"]
#| collect: "test"
hurl --variable post_id=1 --curl tests/results/get-user-name-by-post.curl \
  tests/get-user-name-by-post.hurl \
  | jq .name > tests/results/get-user-name-by-post.txt 2>&1
```
