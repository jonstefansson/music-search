# Elasticsearch Query Notes

## Term Queries

A [Term Query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html) is intended to be applied to fields that are not `not_analyzed`. It looks for the **exact** term in the field's inverted index.

Most string fields are analyzed, so an exact match on the inverted index will not produce the results you expect.

Analyzed fields should be searched with a [match query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query.html).
