<a id="scrapling.core.custom_types"></a>

# scrapling.core.custom\_types

<a id="scrapling.core.custom_types.TextHandler"></a>

## TextHandler Objects

```python
class TextHandler(str)
```

Extends standard Python string by adding more functionality

<a id="scrapling.core.custom_types.TextHandler.sort"></a>

#### sort

```python
def sort(reverse: bool = False) -> Union[str, "TextHandler"]
```

Return a sorted version of the string

<a id="scrapling.core.custom_types.TextHandler.clean"></a>

#### clean

```python
def clean(remove_entities=False) -> Union[str, "TextHandler"]
```

Return a new version of the string after removing all white spaces and consecutive spaces

<a id="scrapling.core.custom_types.TextHandler.json"></a>

#### json

```python
def json() -> Dict
```

Return JSON response if the response is jsonable otherwise throw error

<a id="scrapling.core.custom_types.TextHandler.re"></a>

#### re

```python
def re(regex: str | Pattern,
       replace_entities: bool = True,
       clean_match: bool = False,
       case_sensitive: bool = True,
       check_match: bool = False) -> Union["TextHandlers", bool]
```

Apply the given regex to the current text and return a list of strings with the matches.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `replace_entities`: If enabled character entity references are replaced by their corresponding character
- `clean_match`: If enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: If disabled, function will set the regex to ignore the letters-case while compiling it
- `check_match`: Used to quickly check if this regex matches or not without any operations on the results

<a id="scrapling.core.custom_types.TextHandler.re_first"></a>

#### re\_first

```python
def re_first(regex: str | Pattern,
             default: Any = None,
             replace_entities: bool = True,
             clean_match: bool = False,
             case_sensitive: bool = True) -> "TextHandler"
```

Apply the given regex to text and return the first match if found, otherwise return the default value.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `default`: The default value to be returned if there is no match
- `replace_entities`: If enabled character entity references are replaced by their corresponding character
- `clean_match`: If enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: If disabled, function will set the regex to ignore the letters-case while compiling it

<a id="scrapling.core.custom_types.TextHandlers"></a>

## TextHandlers Objects

```python
class TextHandlers(List[TextHandler])
```

The :class:`TextHandlers` class is a subclass of the builtin ``List`` class, which provides a few additional methods.

<a id="scrapling.core.custom_types.TextHandlers.re"></a>

#### re

```python
def re(regex: str | Pattern,
       replace_entities: bool = True,
       clean_match: bool = False,
       case_sensitive: bool = True) -> "TextHandlers"
```

Call the ``.re()`` method for each element in this list and return

their results flattened as TextHandlers.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `replace_entities`: If enabled character entity references are replaced by their corresponding character
- `clean_match`: if enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: if disabled, the function will set the regex to ignore the letters-case while compiling it

<a id="scrapling.core.custom_types.TextHandlers.re_first"></a>

#### re\_first

```python
def re_first(regex: str | Pattern,
             default: Any = None,
             replace_entities: bool = True,
             clean_match: bool = False,
             case_sensitive: bool = True) -> TextHandler
```

Call the ``.re_first()`` method for each element in this list and return

the first result or the default value otherwise.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `default`: The default value to be returned if there is no match
- `replace_entities`: If enabled character entity references are replaced by their corresponding character
- `clean_match`: If enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: If disabled, function will set the regex to ignore the letters-case while compiling it

<a id="scrapling.core.custom_types.TextHandlers.get"></a>

#### get

```python
def get(default=None)
```

Returns the first item of the current list

**Arguments**:

- `default`: the default value to return if the current list is empty

<a id="scrapling.core.custom_types.AttributesHandler"></a>

## AttributesHandler Objects

```python
class AttributesHandler(Mapping[str, _TextHandlerType])
```

A read-only mapping to use instead of the standard dictionary for the speed boost, but at the same time I use it to add more functionalities.
If the standard dictionary is needed, convert this class to a dictionary with the `dict` function

<a id="scrapling.core.custom_types.AttributesHandler.get"></a>

#### get

```python
def get(key: str, default: Any = None) -> _TextHandlerType
```

Acts like the standard dictionary `.get()` method

<a id="scrapling.core.custom_types.AttributesHandler.search_values"></a>

#### search\_values

```python
def search_values(
        keyword: str,
        partial: bool = False) -> Generator["AttributesHandler", None, None]
```

Search current attributes by values and return a dictionary of each matching item

**Arguments**:

- `keyword`: The keyword to search for in the attribute values
- `partial`: If True, the function will search if keyword in each value instead of perfect match

<a id="scrapling.core.custom_types.AttributesHandler.json_string"></a>

#### json\_string

```python
@property
def json_string() -> bytes
```

Convert current attributes to JSON bytes if the attributes are JSON serializable otherwise throws error

