<a id="scrapling.parser"></a>

# scrapling.parser

<a id="scrapling.parser.Selector"></a>

## Selector Objects

```python
class Selector(SelectorsGeneration)
```

<a id="scrapling.parser.Selector.__init__"></a>

#### \_\_init\_\_

```python
def __init__(content: Optional[str | bytes] = None,
             url: str = "",
             encoding: str = "utf-8",
             huge_tree: bool = True,
             root: Optional[HtmlElement] = None,
             keep_comments: Optional[bool] = False,
             keep_cdata: Optional[bool] = False,
             adaptive: Optional[bool] = False,
             _storage: Optional[StorageSystemMixin] = None,
             storage: Any = SQLiteStorageSystem,
             storage_args: Optional[Dict] = None,
             **_)
```

The main class that works as a wrapper for the HTML input data. Using this class, you can search for elements

with expressions in CSS, XPath, or with simply text. Check the docs for more info.

Here we try to extend module ``lxml.html.HtmlElement`` while maintaining a simpler interface, We are not
inheriting from the ``lxml.html.HtmlElement`` because it's not pickleable, which makes a lot of reference jobs
not possible. You can test it here and see code explodes with `AssertionError: invalid Element proxy at...`.
It's an old issue with lxml, see `this entry <https://bugs.launchpad.net/lxml/+bug/736708>`

**Arguments**:

- `content`: HTML content as either string or bytes.
- `url`: It allows storing a URL with the HTML data for retrieving later.
- `encoding`: The encoding type that will be used in HTML parsing, default is `UTF-8`
- `huge_tree`: Enabled by default, should always be enabled when parsing large HTML documents. This controls
the libxml2 feature that forbids parsing certain large documents to protect from possible memory exhaustion.
- `root`: Used internally to pass etree objects instead of text/body arguments, it takes the highest priority.
Don't use it unless you know what you are doing!
- `keep_comments`: While parsing the HTML body, drop comments or not. Disabled by default for obvious reasons
- `keep_cdata`: While parsing the HTML body, drop cdata or not. Disabled by default for cleaner HTML.
- `adaptive`: Globally turn off the adaptive feature in all functions, this argument takes higher
priority over all adaptive related arguments/functions in the class.
- `storage`: The storage class to be passed for adaptive functionalities, see ``Docs`` for more info.
- `storage_args`: A dictionary of ``argument->value`` pairs to be passed for the storage class.
If empty, default values will be used.

<a id="scrapling.parser.Selector.tag"></a>

#### tag

```python
@property
def tag() -> str
```

Get the tag name of the element

<a id="scrapling.parser.Selector.text"></a>

#### text

```python
@property
def text() -> TextHandler
```

Get text content of the element

<a id="scrapling.parser.Selector.get_all_text"></a>

#### get\_all\_text

```python
def get_all_text(separator: str = "\n",
                 strip: bool = False,
                 ignore_tags: Tuple = (
                     "script",
                     "style",
                 ),
                 valid_values: bool = True) -> TextHandler
```

Get all child strings of this element, concatenated using the given separator.

**Arguments**:

- `separator`: Strings will be concatenated using this separator.
- `strip`: If True, strings will be stripped before being concatenated.
- `ignore_tags`: A tuple of all tag names you want to ignore
- `valid_values`: If enabled, elements with text-content that is empty or only whitespaces will be ignored

**Returns**:

A TextHandler

<a id="scrapling.parser.Selector.urljoin"></a>

#### urljoin

```python
def urljoin(relative_url: str) -> str
```

Join this Selector's url with a relative url to form an absolute full URL.

<a id="scrapling.parser.Selector.attrib"></a>

#### attrib

```python
@property
def attrib() -> AttributesHandler
```

Get attributes of the element

<a id="scrapling.parser.Selector.html_content"></a>

#### html\_content

```python
@property
def html_content() -> TextHandler
```

Return the inner HTML code of the element

<a id="scrapling.parser.Selector.body"></a>

#### body

```python
@property
def body() -> str | bytes
```

Return the raw body of the current `Selector` without any processing. Useful for binary and non-HTML requests.

<a id="scrapling.parser.Selector.prettify"></a>

#### prettify

```python
def prettify() -> TextHandler
```

Return a prettified version of the element's inner html-code

<a id="scrapling.parser.Selector.has_class"></a>

#### has\_class

```python
def has_class(class_name: str) -> bool
```

Check if the element has a specific class

**Arguments**:

- `class_name`: The class name to check for

**Returns**:

True if element has class with that name otherwise False

<a id="scrapling.parser.Selector.parent"></a>

#### parent

```python
@property
def parent() -> Optional["Selector"]
```

Return the direct parent of the element or ``None`` otherwise

<a id="scrapling.parser.Selector.below_elements"></a>

#### below\_elements

```python
@property
def below_elements() -> "Selectors"
```

Return all elements under the current element in the DOM tree

<a id="scrapling.parser.Selector.children"></a>

#### children

```python
@property
def children() -> "Selectors"
```

Return the children elements of the current element or empty list otherwise

<a id="scrapling.parser.Selector.siblings"></a>

#### siblings

```python
@property
def siblings() -> "Selectors"
```

Return other children of the current element's parent or empty list otherwise

<a id="scrapling.parser.Selector.iterancestors"></a>

#### iterancestors

```python
def iterancestors() -> Generator["Selector", None, None]
```

Return a generator that loops over all ancestors of the element, starting with the element's parent.

<a id="scrapling.parser.Selector.find_ancestor"></a>

#### find\_ancestor

```python
def find_ancestor(func: Callable[["Selector"], bool]) -> Optional["Selector"]
```

Loop over all ancestors of the element till one match the passed function

**Arguments**:

- `func`: A function that takes each ancestor as an argument and returns True/False

**Returns**:

The first ancestor that match the function or ``None`` otherwise.

<a id="scrapling.parser.Selector.path"></a>

#### path

```python
@property
def path() -> "Selectors"
```

Returns a list of type `Selectors` that contains the path leading to the current element from the root.

<a id="scrapling.parser.Selector.next"></a>

#### next

```python
@property
def next() -> Optional["Selector"]
```

Returns the next element of the current element in the children of the parent or ``None`` otherwise.

<a id="scrapling.parser.Selector.previous"></a>

#### previous

```python
@property
def previous() -> Optional["Selector"]
```

Returns the previous element of the current element in the children of the parent or ``None`` otherwise.

<a id="scrapling.parser.Selector.get"></a>

#### get

```python
def get() -> TextHandler
```

Serialize this element to a string.
For text nodes, returns the text value. For HTML elements, returns the outer HTML.

<a id="scrapling.parser.Selector.getall"></a>

#### getall

```python
def getall() -> TextHandlers
```

Return a single-element list containing this element's serialized string.

<a id="scrapling.parser.Selector.relocate"></a>

#### relocate

```python
def relocate(
        element: Union[Dict, HtmlElement, "Selector"],
        percentage: int = 0,
        selector_type: bool = False) -> Union[List[HtmlElement], "Selectors"]
```

This function will search again for the element in the page tree, used automatically on page structure change

**Arguments**:

- `element`: The element we want to relocate in the tree
- `percentage`: The minimum percentage to accept and not going lower than that. Be aware that the percentage
calculation depends solely on the page structure, so don't play with this number unless you must know
what you are doing!
- `selector_type`: If True, the return result will be converted to `Selectors` object

**Returns**:

List of pure HTML elements that got the highest matching score or 'Selectors' object

<a id="scrapling.parser.Selector.css"></a>

#### css

```python
def css(selector: str,
        identifier: str = "",
        adaptive: bool = False,
        auto_save: bool = False,
        percentage: int = 0) -> "Selectors"
```

Search the current tree with CSS3 selectors

**Important:
It's recommended to use the identifier argument if you plan to use a different selector later
and want to relocate the same element(s)**

**Arguments**:

- `selector`: The CSS3 selector to be used.
- `adaptive`: Enabled will make the function try to relocate the element if it was 'saved' before
- `identifier`: A string that will be used to save/retrieve element's data in adaptive,
otherwise the selector will be used.
- `auto_save`: Automatically save new elements for `adaptive` later
- `percentage`: The minimum percentage to accept while `adaptive` is working and not going lower than that.
Be aware that the percentage calculation depends solely on the page structure, so don't play with this
number unless you must know what you are doing!

**Returns**:

`Selectors` class.

<a id="scrapling.parser.Selector.xpath"></a>

#### xpath

```python
def xpath(selector: str,
          identifier: str = "",
          adaptive: bool = False,
          auto_save: bool = False,
          percentage: int = 0,
          **kwargs: Any) -> "Selectors"
```

Search the current tree with XPath selectors

**Important:
It's recommended to use the identifier argument if you plan to use a different selector later
and want to relocate the same element(s)**

 Note: **Additional keyword arguments will be passed as XPath variables in the XPath expression!**

**Arguments**:

- `selector`: The XPath selector to be used.
- `adaptive`: Enabled will make the function try to relocate the element if it was 'saved' before
- `identifier`: A string that will be used to save/retrieve element's data in adaptive,
otherwise the selector will be used.
- `auto_save`: Automatically save new elements for `adaptive` later
- `percentage`: The minimum percentage to accept while `adaptive` is working and not going lower than that.
Be aware that the percentage calculation depends solely on the page structure, so don't play with this
number unless you must know what you are doing!

**Returns**:

`Selectors` class.

<a id="scrapling.parser.Selector.find_all"></a>

#### find\_all

```python
def find_all(*args: str | Iterable[str] | Pattern | Callable | Dict[str, str],
             **kwargs: str) -> "Selectors"
```

Find elements by filters of your creations for ease.

**Arguments**:

- `args`: Tag name(s), iterable of tag names, regex patterns, function, or a dictionary of elements' attributes. Leave empty for selecting all.
- `kwargs`: The attributes you want to filter elements based on it.

**Returns**:

The `Selectors` object of the elements or empty list

<a id="scrapling.parser.Selector.find"></a>

#### find

```python
def find(*args: str | Iterable[str] | Pattern | Callable | Dict[str, str],
         **kwargs: str) -> Optional["Selector"]
```

Find elements by filters of your creations for ease, then return the first result. Otherwise return `None`.

**Arguments**:

- `args`: Tag name(s), iterable of tag names, regex patterns, function, or a dictionary of elements' attributes. Leave empty for selecting all.
- `kwargs`: The attributes you want to filter elements based on it.

**Returns**:

The `Selector` object of the element or `None` if the result didn't match

<a id="scrapling.parser.Selector.save"></a>

#### save

```python
def save(element: HtmlElement, identifier: str) -> None
```

Saves the element's unique properties to the storage for retrieval and relocation later

**Arguments**:

- `element`: The element itself that we want to save to storage, it can be a ` Selector ` or pure ` HtmlElement `
- `identifier`: This is the identifier that will be used to retrieve the element later from the storage. See
the docs for more info.

<a id="scrapling.parser.Selector.retrieve"></a>

#### retrieve

```python
def retrieve(identifier: str) -> Optional[Dict[str, Any]]
```

Using the identifier, we search the storage and return the unique properties of the element

**Arguments**:

- `identifier`: This is the identifier that will be used to retrieve the element from the storage. See
the docs for more info.

**Returns**:

A dictionary of the unique properties

<a id="scrapling.parser.Selector.json"></a>

#### json

```python
def json() -> Dict
```

Return JSON response if the response is jsonable otherwise throws error

<a id="scrapling.parser.Selector.re"></a>

#### re

```python
def re(regex: str | Pattern[str],
       replace_entities: bool = True,
       clean_match: bool = False,
       case_sensitive: bool = True) -> TextHandlers
```

Apply the given regex to the current text and return a list of strings with the matches.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `replace_entities`: If enabled character entity references are replaced by their corresponding character
- `clean_match`: if enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: if disabled, the function will set the regex to ignore the letters case while compiling it

<a id="scrapling.parser.Selector.re_first"></a>

#### re\_first

```python
def re_first(regex: str | Pattern[str],
             default=None,
             replace_entities: bool = True,
             clean_match: bool = False,
             case_sensitive: bool = True) -> TextHandler
```

Apply the given regex to text and return the first match if found, otherwise return the default value.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `default`: The default value to be returned if there is no match
- `replace_entities`: if enabled character entity references are replaced by their corresponding character
- `clean_match`: if enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: if disabled, the function will set the regex to ignore the letters case while compiling it

<a id="scrapling.parser.Selector.find_similar"></a>

#### find\_similar

```python
def find_similar(similarity_threshold: float = 0.2,
                 ignore_attributes: List | Tuple = (
                     "href",
                     "src",
                 ),
                 match_text: bool = False) -> "Selectors"
```

Find elements that are in the same tree depth in the page with the same tag name and same parent tag etc...

then return the ones that match the current element attributes with a percentage higher than the input threshold.

This function is inspired by AutoScraper and made for cases where you, for example, found a product div inside
a products-list container and want to find other products using that element as a starting point EXCEPT
this function works in any case without depending on the element type.

**Arguments**:

- `similarity_threshold`: The percentage to use while comparing element attributes.
Note: Elements found before attributes matching/comparison will be sharing the same depth, same tag name,
same parent tag name, and same grand parent tag name. So they are 99% likely to be correct unless you are
extremely unlucky, then attributes matching comes into play, so don't play with this number unless
you are getting the results you don't want.
Also, if the current element doesn't have attributes and the similar element as well, then it's a 100% match.
- `ignore_attributes`: Attribute names passed will be ignored while matching the attributes in the last step.
The default value is to ignore `href` and `src` as URLs can change a lot between elements, so it's unreliable
- `match_text`: If True, element text content will be taken into calculation while matching.
Not recommended to use in normal cases, but it depends.

**Returns**:

A ``Selectors`` container of ``Selector`` objects or empty list

<a id="scrapling.parser.Selector.find_by_text"></a>

#### find\_by\_text

```python
def find_by_text(text: str,
                 first_match: bool = True,
                 partial: bool = False,
                 case_sensitive: bool = False,
                 clean_match: bool = True) -> Union["Selectors", "Selector"]
```

Find elements that its text content fully/partially matches input.

**Arguments**:

- `text`: Text query to match
- `first_match`: Returns the first element that matches conditions, enabled by default
- `partial`: If enabled, the function returns elements that contain the input text
- `case_sensitive`: if enabled, the letters case will be taken into consideration
- `clean_match`: if enabled, this will ignore all whitespaces and consecutive spaces while matching

<a id="scrapling.parser.Selector.find_by_regex"></a>

#### find\_by\_regex

```python
def find_by_regex(query: str | Pattern[str],
                  first_match: bool = True,
                  case_sensitive: bool = False,
                  clean_match: bool = True) -> Union["Selectors", "Selector"]
```

Find elements that its text content matches the input regex pattern.

**Arguments**:

- `query`: Regex query/pattern to match
- `first_match`: Return the first element that matches conditions; enabled by default.
- `case_sensitive`: If enabled, the letters case will be taken into consideration in the regex.
- `clean_match`: If enabled, this will ignore all whitespaces and consecutive spaces while matching.

<a id="scrapling.parser.Selectors"></a>

## Selectors Objects

```python
class Selectors(List[Selector])
```

The `Selectors` class is a subclass of the builtin ``List`` class, which provides a few additional methods.

<a id="scrapling.parser.Selectors.xpath"></a>

#### xpath

```python
def xpath(selector: str,
          identifier: str = "",
          auto_save: bool = False,
          percentage: int = 0,
          **kwargs: Any) -> "Selectors"
```

Call the ``.xpath()`` method for each element in this list and return

their results as another `Selectors` class.

**Important:
It's recommended to use the identifier argument if you plan to use a different selector later
and want to relocate the same element(s)**

 Note: **Additional keyword arguments will be passed as XPath variables in the XPath expression!**

**Arguments**:

- `selector`: The XPath selector to be used.
- `identifier`: A string that will be used to retrieve element's data in adaptive,
otherwise the selector will be used.
- `auto_save`: Automatically save new elements for `adaptive` later
- `percentage`: The minimum percentage to accept while `adaptive` is working and not going lower than that.
Be aware that the percentage calculation depends solely on the page structure, so don't play with this
number unless you must know what you are doing!

**Returns**:

`Selectors` class.

<a id="scrapling.parser.Selectors.css"></a>

#### css

```python
def css(selector: str,
        identifier: str = "",
        auto_save: bool = False,
        percentage: int = 0) -> "Selectors"
```

Call the ``.css()`` method for each element in this list and return

their results flattened as another `Selectors` class.

**Important:
It's recommended to use the identifier argument if you plan to use a different selector later
and want to relocate the same element(s)**

**Arguments**:

- `selector`: The CSS3 selector to be used.
- `identifier`: A string that will be used to retrieve element's data in adaptive,
otherwise the selector will be used.
- `auto_save`: Automatically save new elements for `adaptive` later
- `percentage`: The minimum percentage to accept while `adaptive` is working and not going lower than that.
Be aware that the percentage calculation depends solely on the page structure, so don't play with this
number unless you must know what you are doing!

**Returns**:

`Selectors` class.

<a id="scrapling.parser.Selectors.re"></a>

#### re

```python
def re(regex: str | Pattern,
       replace_entities: bool = True,
       clean_match: bool = False,
       case_sensitive: bool = True) -> TextHandlers
```

Call the ``.re()`` method for each element in this list and return

their results flattened as List of TextHandler.

**Arguments**:

- `regex`: Can be either a compiled regular expression or a string.
- `replace_entities`: If enabled character entity references are replaced by their corresponding character
- `clean_match`: if enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: if disabled, the function will set the regex to ignore the letters case while compiling it

<a id="scrapling.parser.Selectors.re_first"></a>

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
- `replace_entities`: if enabled character entity references are replaced by their corresponding character
- `clean_match`: if enabled, this will ignore all whitespaces and consecutive spaces while matching
- `case_sensitive`: if disabled, function will set the regex to ignore the letters case while compiling it

<a id="scrapling.parser.Selectors.search"></a>

#### search

```python
def search(func: Callable[["Selector"], bool]) -> Optional["Selector"]
```

Loop over all current elements and return the first element that matches the passed function

**Arguments**:

- `func`: A function that takes each element as an argument and returns True/False

**Returns**:

The first element that match the function or ``None`` otherwise.

<a id="scrapling.parser.Selectors.filter"></a>

#### filter

```python
def filter(func: Callable[["Selector"], bool]) -> "Selectors"
```

Filter current elements based on the passed function

**Arguments**:

- `func`: A function that takes each element as an argument and returns True/False

**Returns**:

The new `Selectors` object or empty list otherwise.

<a id="scrapling.parser.Selectors.get"></a>

#### get

```python
def get(default=None)
```

Returns the serialized string of the first element, or ``default`` if empty.

**Arguments**:

- `default`: the default value to return if the current list is empty

<a id="scrapling.parser.Selectors.getall"></a>

#### getall

```python
def getall() -> TextHandlers
```

Serialize all elements and return as a TextHandlers list.

<a id="scrapling.parser.Selectors.first"></a>

#### first

```python
@property
def first() -> Optional[Selector]
```

Returns the first Selector item of the current list or `None` if the list is empty

<a id="scrapling.parser.Selectors.last"></a>

#### last

```python
@property
def last() -> Optional[Selector]
```

Returns the last Selector item of the current list or `None` if the list is empty

<a id="scrapling.parser.Selectors.length"></a>

#### length

```python
@property
def length() -> int
```

Returns the length of the current list

