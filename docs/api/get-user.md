## Get a user

``` { .hurl file=tests/get-user.hurl #get-user }
GET https://jsonplaceholder.typicode.com/users/{{user_id}}
HTTP 200
[Asserts]
<<application-json-header-assert>>
jsonpath "$.id" == {{user_id}}
jsonpath "$.name" exists
```

Run it:

``` { .bash .task }
#| description: "run get-user"
#| requires: "tests/get-user.hurl"
#| creates: ["tests/results/get-user.txt", "tests/results/get-user.curl"]
#| collect: "test"
hurl --variable user_id=1 --curl tests/results/get-user.curl \
  tests/get-user.hurl > tests/results/get-user.txt 2>&1
```
