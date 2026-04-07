<a id="scrapling.engines.toolbelt.custom"></a>

# scrapling.engines.toolbelt.custom

Functions related to custom types or type checking

<a id="scrapling.engines.toolbelt.custom.Response"></a>

## Response Objects

```python
class Response(Selector)
```

This class is returned by all engines as a way to unify the response type between different libraries.

**Arguments**:

- `status`: HTTP status code.
- `reason`: HTTP status message.
- `cookies`: Response cookies.
- `headers`: Response headers.
- `request_headers`: Request headers sent with the request.
- `history`: List of redirect responses, if any.
- `meta`: Metadata dictionary (e.g., proxy used).
- `request`: Associated spider Request object (set by crawler, in the spiders framework).
- `captured_xhr`: List of captured XHR/fetch ``Response`` objects. Populated when ``capture_xhr`` is set on a browser session.

<a id="scrapling.engines.toolbelt.custom.Response.body"></a>

#### body

```python
@property
def body() -> bytes
```

Return the raw body of the response as bytes.

<a id="scrapling.engines.toolbelt.custom.Response.follow"></a>

#### follow

```python
def follow(url: str,
           sid: str = "",
           callback: Callable[["Response"],
                              AsyncGenerator[Union[Dict[str, Any], "Request",
                                                   None], None]] | None = None,
           priority: int | None = None,
           dont_filter: bool = False,
           meta: dict[str, Any] | None = None,
           referer_flow: bool = True,
           **kwargs: Any) -> Any
```

Create a Request to follow a URL.

This is a helper method for spiders to easily follow links found in pages.

**IMPORTANT**: The below arguments if left empty, the corresponding value from the previous request will be used. The only exception is `dont_filter`.

**Arguments**:

- `url`: The URL to follow (can be relative, will be joined with current URL)
- `sid`: The session id to use
- `callback`: Spider callback method to use
- `priority`: The priority number to use, the higher the number, the higher priority to be processed first.
- `dont_filter`: If this request has been done before, disable the filter to allow it again.
- `meta`: Additional meta data to included in the request
- `referer_flow`: Enabled by default, set the current response url as referer for the new request url.
- `kwargs`: Additional Request arguments

**Returns**:

Request object ready to be yielded

<a id="scrapling.engines.toolbelt.custom.BaseFetcher"></a>

## BaseFetcher Objects

```python
class BaseFetcher()
```

<a id="scrapling.engines.toolbelt.custom.BaseFetcher.parser_keywords"></a>

#### parser\_keywords

Left open for the user

<a id="scrapling.engines.toolbelt.custom.BaseFetcher.configure"></a>

#### configure

```python
@classmethod
def configure(cls, **kwargs)
```

Set multiple arguments for the parser at once globally

**Arguments**:

- `kwargs`: The keywords can be any arguments of the following: huge_tree, keep_comments, keep_cdata, adaptive, storage, storage_args, adaptive_domain

<a id="scrapling.engines.toolbelt.custom.StatusText"></a>

## StatusText Objects

```python
class StatusText()
```

A class that gets the status text of the response status code.

Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

<a id="scrapling.engines.toolbelt.custom.StatusText.get"></a>

#### get

```python
@classmethod
@lru_cache(maxsize=128)
def get(cls, status_code: int) -> str
```

Get the phrase for a given HTTP status code.

