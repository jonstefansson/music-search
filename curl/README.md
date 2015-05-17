# Elasticsearch Query Notes

## Term Queries

A [Term Query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html) is intended to be applied to fields that are not `not_analyzed`. It looks for the **exact** term in the field's inverted index.

Most string fields are analyzed, so an exact match on the inverted index will not produce the results you expect.

Analyzed fields should be searched with a [match query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query.html).

## Match Queries

[Match Queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query.html) are good for searches from a web form's search input field. And the `phrase-prefix` variant is intended for autocomplete search fields.

>The match family of queries does not go through a "query parsing" process. It does not support field name prefixes, wildcard characters, or other "advanced" features. For this reason, chances of it failing are very small / non existent, and it provides an excellent behavior when it comes to just analyze and run that text as a query behavior (which is usually what a text search box does). Also, the phrase_prefix type can provide a great "as you type" behavior to automatically load search results.
