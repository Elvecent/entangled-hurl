## Get a user

``` {.hurl file=tests/get-user.hurl}
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
#| creates: "tests/results/get-user.txt"
#| collect: "test"
hurl --variable user_id=1 tests/get-user.hurl \
  > tests/results/get-user.txt 2>&1
```

``` result
tests/results/get-user.txt
```

## Utils

Check that `Content-Type` header contains `application/json`.

``` { .hurl #application-json-header-assert }
header "Content-Type" contains "application/json"

```
