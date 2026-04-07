<a id="scrapling.spiders"></a>

# scrapling.spiders

<a id="scrapling.spiders.result"></a>

# scrapling.spiders.result

<a id="scrapling.spiders.result.ItemList"></a>

## ItemList Objects

```python
class ItemList(list)
```

A list of scraped items with export capabilities.

<a id="scrapling.spiders.result.ItemList.to_json"></a>

#### to\_json

```python
def to_json(path: Union[str, Path], *, indent: bool = False)
```

Export items to a JSON file.

**Arguments**:

- `path`: Path to the output file
- `indent`: Pretty-print with 2-space indentation (slightly slower)

<a id="scrapling.spiders.result.ItemList.to_jsonl"></a>

#### to\_jsonl

```python
def to_jsonl(path: Union[str, Path])
```

Export items as JSON Lines (one JSON object per line).

**Arguments**:

- `path`: Path to the output file

<a id="scrapling.spiders.result.CrawlStats"></a>

## CrawlStats Objects

```python
@dataclass
class CrawlStats()
```

Statistics for a crawl run.

<a id="scrapling.spiders.result.CrawlResult"></a>

## CrawlResult Objects

```python
@dataclass
class CrawlResult()
```

Complete result from a spider run.

<a id="scrapling.spiders.result.CrawlResult.completed"></a>

#### completed

```python
@property
def completed() -> bool
```

True if the crawl completed normally (not paused).

<a id="scrapling.spiders.session"></a>

# scrapling.spiders.session

<a id="scrapling.spiders.session.SessionManager"></a>

## SessionManager Objects

```python
class SessionManager()
```

Manages pre-configured session instances.

<a id="scrapling.spiders.session.SessionManager.add"></a>

#### add

```python
def add(session_id: str,
        session: Session,
        *,
        default: bool = False,
        lazy: bool = False) -> "SessionManager"
```

Register a session instance.

**Arguments**:

- `session_id`: Name to reference this session in requests
- `session`: Your pre-configured session instance
- `default`: If True, this becomes the default session
- `lazy`: If True, the session will be started only when a request uses its ID.

<a id="scrapling.spiders.session.SessionManager.remove"></a>

#### remove

```python
def remove(session_id: str) -> None
```

Removes a session.

**Arguments**:

- `session_id`: ID of session to remove

<a id="scrapling.spiders.session.SessionManager.pop"></a>

#### pop

```python
def pop(session_id: str) -> Session
```

Remove and returns a session.

**Arguments**:

- `session_id`: ID of session to remove

<a id="scrapling.spiders.session.SessionManager.start"></a>

#### start

```python
async def start() -> None
```

Start all sessions that aren't already alive.

<a id="scrapling.spiders.session.SessionManager.close"></a>

#### close

```python
async def close() -> None
```

Close all registered sessions.

<a id="scrapling.spiders.session.SessionManager.__contains__"></a>

#### \_\_contains\_\_

```python
def __contains__(session_id: str) -> bool
```

Check if a session ID is registered.

<a id="scrapling.spiders.session.SessionManager.__len__"></a>

#### \_\_len\_\_

```python
def __len__() -> int
```

Number of registered sessions.

