<a id="scrapling.engines.toolbelt.proxy_rotation"></a>

# scrapling.engines.toolbelt.proxy\_rotation

<a id="scrapling.engines.toolbelt.proxy_rotation.is_proxy_error"></a>

#### is\_proxy\_error

```python
def is_proxy_error(error: Exception) -> bool
```

Check if an error is proxy-related. Works for both HTTP and browser errors.

<a id="scrapling.engines.toolbelt.proxy_rotation.cyclic_rotation"></a>

#### cyclic\_rotation

```python
def cyclic_rotation(proxies: List[ProxyType],
                    current_index: int) -> Tuple[ProxyType, int]
```

Default cyclic rotation strategy - iterates through proxies sequentially, wrapping around at the end.

<a id="scrapling.engines.toolbelt.proxy_rotation.ProxyRotator"></a>

## ProxyRotator Objects

```python
class ProxyRotator()
```

A thread-safe proxy rotator with pluggable rotation strategies.

Supports:
- Cyclic rotation (default)
- Custom rotation strategies via callable
- Both string URLs and Playwright-style dict proxies

<a id="scrapling.engines.toolbelt.proxy_rotation.ProxyRotator.__init__"></a>

#### \_\_init\_\_

```python
def __init__(proxies: List[ProxyType],
             strategy: RotationStrategy = cyclic_rotation)
```

Initialize the proxy rotator.

**Arguments**:

- `proxies`: List of proxy URLs or Playwright-style proxy dicts.
- String format: "http://proxy1:8080" or "http://user:pass@proxy:8080"
- Dict format: {"server": "http://proxy:8080", "username": "user", "password": "pass"}
- `strategy`: Rotation strategy function. Takes (proxies, current_index) and returns (proxy, next_index). Defaults to cyclic_rotation.

<a id="scrapling.engines.toolbelt.proxy_rotation.ProxyRotator.get_proxy"></a>

#### get\_proxy

```python
def get_proxy() -> ProxyType
```

Get the next proxy according to the rotation strategy.

<a id="scrapling.engines.toolbelt.proxy_rotation.ProxyRotator.proxies"></a>

#### proxies

```python
@property
def proxies() -> List[ProxyType]
```

Get a copy of all configured proxies.

<a id="scrapling.engines.toolbelt.proxy_rotation.ProxyRotator.__len__"></a>

#### \_\_len\_\_

```python
def __len__() -> int
```

Return the total number of configured proxies.

