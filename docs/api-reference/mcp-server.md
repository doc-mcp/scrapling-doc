<a id="scrapling.core.ai"></a>

# scrapling.core.ai

<a id="scrapling.core.ai.ResponseModel"></a>

## ResponseModel Objects

```python
class ResponseModel(BaseModel)
```

Request's response information structure.

<a id="scrapling.core.ai.SessionInfo"></a>

## SessionInfo Objects

```python
class SessionInfo(BaseModel)
```

Information about an open browser session.

<a id="scrapling.core.ai.SessionCreatedModel"></a>

## SessionCreatedModel Objects

```python
class SessionCreatedModel(SessionInfo)
```

Response returned when a new session is created.

<a id="scrapling.core.ai.SessionClosedModel"></a>

## SessionClosedModel Objects

```python
class SessionClosedModel(BaseModel)
```

Response returned when a session is closed.

<a id="scrapling.core.ai._SessionEntry"></a>

## \_SessionEntry Objects

```python
@dataclass
class _SessionEntry()
```

<a id="scrapling.core.ai._SessionEntry.session"></a>

#### session

AsyncDynamicSession | AsyncStealthySession

<a id="scrapling.core.ai.ScraplingMCPServer"></a>

## ScraplingMCPServer Objects

```python
class ScraplingMCPServer()
```

<a id="scrapling.core.ai.ScraplingMCPServer.open_session"></a>

#### open\_session

```python
async def open_session(
        session_type: SessionType,
        headless: bool = True,
        google_search: bool = True,
        real_chrome: bool = False,
        wait: int | float = 0,
        proxy: Optional[str | Dict[str, str]] = None,
        timezone_id: str | None = None,
        locale: str | None = None,
        extra_headers: Optional[Dict[str, str]] = None,
        useragent: Optional[str] = None,
        cdp_url: Optional[str] = None,
        timeout: int | float = 30000,
        disable_resources: bool = False,
        wait_selector: Optional[str] = None,
        cookies: Sequence[SetCookieParam] | None = None,
        network_idle: bool = False,
        wait_selector_state: SelectorWaitStates = "attached",
        max_pages: int = 5,
        hide_canvas: bool = False,
        block_webrtc: bool = False,
        allow_webgl: bool = True,
        solve_cloudflare: bool = False,
        additional_args: Optional[Dict] = None) -> SessionCreatedModel
```

Open a persistent browser session that can be reused across multiple fetch calls.

This avoids the overhead of launching a new browser for each request.
Use close_session to close the session when done, and list_sessions to see all active sessions.

**Arguments**:

- `session_type`: The type of session to open. Use "dynamic" for standard Playwright browser, or "stealthy" for anti-bot bypass with fingerprint spoofing.
- `headless`: Run the browser in headless/hidden (default), or headful/visible mode.
- `google_search`: Enabled by default, Scrapling will set a Google referer header.
- `real_chrome`: If you have a Chrome browser installed on your device, enable this, and the Fetcher will launch an instance of your browser and use it.
- `wait`: The time (milliseconds) the fetcher will wait after everything finishes before closing the page and returning the Response object.
- `proxy`: The proxy to be used with requests, it can be a string or a dictionary with the keys 'server', 'username', and 'password' only.
- `timezone_id`: Changes the timezone of the browser. Defaults to the system timezone.
- `locale`: Specify user locale, for example, `en-GB`, `de-DE`, etc.
- `extra_headers`: A dictionary of extra headers to add to the request.
- `useragent`: Pass a useragent string to be used. Otherwise the fetcher will generate a real Useragent of the same browser and use it.
- `cdp_url`: Instead of launching a new browser instance, connect to this CDP URL to control real browsers through CDP.
- `timeout`: The timeout in milliseconds that is used in all operations and waits through the page. The default is 30,000.
- `disable_resources`: Drop requests for unnecessary resources for a speed boost.
- `wait_selector`: Wait for a specific CSS selector to be in a specific state.
- `cookies`: Set cookies for the session. It should be in a dictionary format that Playwright accepts.
- `network_idle`: Wait for the page until there are no network connections for at least 500 ms.
- `wait_selector_state`: The state to wait for the selector given with `wait_selector`. The default state is `attached`.
- `max_pages`: Maximum number of concurrent pages/tabs in the browser. Defaults to 5. Higher values allow more parallel fetches.
- `hide_canvas`: (Stealthy only) Add random noise to canvas operations to prevent fingerprinting.
- `block_webrtc`: (Stealthy only) Forces WebRTC to respect proxy settings to prevent local IP address leak.
- `allow_webgl`: (Stealthy only) Enabled by default. Disabling WebGL is not recommended as many WAFs now check if WebGL is enabled.
- `solve_cloudflare`: (Stealthy only) Solves all types of the Cloudflare's Turnstile/Interstitial challenges.
- `additional_args`: (Stealthy only) Additional arguments to be passed to Playwright's context as additional settings.

<a id="scrapling.core.ai.ScraplingMCPServer.close_session"></a>

#### close\_session

```python
async def close_session(session_id: str) -> SessionClosedModel
```

Close a persistent browser session and free its resources.

**Arguments**:

- `session_id`: The unique identifier of the session to close. Use list_sessions to see active sessions.

<a id="scrapling.core.ai.ScraplingMCPServer.list_sessions"></a>

#### list\_sessions

```python
async def list_sessions() -> List[SessionInfo]
```

List all active browser sessions with their details.

<a id="scrapling.core.ai.ScraplingMCPServer.get"></a>

#### get

```python
@staticmethod
async def get(url: str,
              impersonate: ImpersonateType = "chrome",
              extraction_type: extraction_types = "markdown",
              css_selector: Optional[str] = None,
              main_content_only: bool = True,
              params: Optional[Dict] = None,
              headers: Optional[Mapping[str, Optional[str]]] = None,
              cookies: Optional[Dict[str, str]] = None,
              timeout: Optional[int | float] = 30,
              follow_redirects: FollowRedirects = "safe",
              max_redirects: int = 30,
              retries: Optional[int] = 3,
              retry_delay: Optional[int] = 1,
              proxy: Optional[str] = None,
              proxy_auth: Optional[Dict[str, str]] = None,
              auth: Optional[Dict[str, str]] = None,
              verify: Optional[bool] = True,
              http3: Optional[bool] = False,
              stealthy_headers: Optional[bool] = True) -> ResponseModel
```

Make GET HTTP request to a URL and return a structured output of the result.

Note: This is only suitable for low-mid protection levels. For high-protection levels or websites that require JS loading, use the other tools directly.
Note: If the `css_selector` resolves to more than one element, all the elements will be returned.

**Arguments**:

- `url`: The URL to request.
- `impersonate`: Browser version to impersonate its fingerprint. It's using the latest chrome version by default.
- `extraction_type`: The type of content to extract from the page. Defaults to "markdown". Options are:
- Markdown will convert the page content to Markdown format.
- HTML will return the raw HTML content of the page.
- Text will return the text content of the page.
- `css_selector`: CSS selector to extract the content from the page. If main_content_only is True, then it will be executed on the main content of the page. Defaults to None.
- `main_content_only`: Whether to extract only the main content of the page. Defaults to True. The main content here is the data inside the `<body>` tag.
- `params`: Query string parameters for the request.
- `headers`: Headers to include in the request.
- `cookies`: Cookies to use in the request.
- `timeout`: Number of seconds to wait before timing out.
- `follow_redirects`: Whether to follow redirects. Defaults to "safe", which follows redirects but rejects those targeting internal/private IPs (SSRF protection). Pass True to follow all redirects without restriction.
- `max_redirects`: Maximum number of redirects. Default 30, use -1 for unlimited.
- `retries`: Number of retry attempts. Defaults to 3.
- `retry_delay`: Number of seconds to wait between retry attempts. Defaults to 1 second.
- `proxy`: Proxy URL to use. Format: "http://username:password@localhost:8030".
Cannot be used together with the `proxies` parameter.
- `proxy_auth`: HTTP basic auth for proxy in dictionary format with `username` and `password` keys.
- `auth`: HTTP basic auth in dictionary format with `username` and `password` keys.
- `verify`: Whether to verify HTTPS certificates.
- `http3`: Whether to use HTTP3. Defaults to False. It might be problematic if used it with `impersonate`.
- `stealthy_headers`: If enabled (default), it creates and adds real browser headers. It also sets a Google referer header.

<a id="scrapling.core.ai.ScraplingMCPServer.bulk_get"></a>

#### bulk\_get

```python
@staticmethod
async def bulk_get(
        urls: List[str],
        impersonate: ImpersonateType = "chrome",
        extraction_type: extraction_types = "markdown",
        css_selector: Optional[str] = None,
        main_content_only: bool = True,
        params: Optional[Dict] = None,
        headers: Optional[Mapping[str, Optional[str]]] = None,
        cookies: Optional[Dict[str, str]] = None,
        timeout: Optional[int | float] = 30,
        follow_redirects: FollowRedirects = "safe",
        max_redirects: int = 30,
        retries: Optional[int] = 3,
        retry_delay: Optional[int] = 1,
        proxy: Optional[str] = None,
        proxy_auth: Optional[Dict[str, str]] = None,
        auth: Optional[Dict[str, str]] = None,
        verify: Optional[bool] = True,
        http3: Optional[bool] = False,
        stealthy_headers: Optional[bool] = True) -> List[ResponseModel]
```

Make GET HTTP request to a group of URLs and for each URL, return a structured output of the result.

Note: This is only suitable for low-mid protection levels. For high-protection levels or websites that require JS loading, use the other tools directly.
Note: If the `css_selector` resolves to more than one element, all the elements will be returned.

**Arguments**:

- `urls`: A list of the URLs to request.
- `impersonate`: Browser version to impersonate its fingerprint. It's using the latest chrome version by default.
- `extraction_type`: The type of content to extract from the page. Defaults to "markdown". Options are:
- Markdown will convert the page content to Markdown format.
- HTML will return the raw HTML content of the page.
- Text will return the text content of the page.
- `css_selector`: CSS selector to extract the content from the page. If main_content_only is True, then it will be executed on the main content of the page. Defaults to None.
- `main_content_only`: Whether to extract only the main content of the page. Defaults to True. The main content here is the data inside the `<body>` tag.
- `params`: Query string parameters for the request.
- `headers`: Headers to include in the request.
- `cookies`: Cookies to use in the request.
- `timeout`: Number of seconds to wait before timing out.
- `follow_redirects`: Whether to follow redirects. Defaults to "safe", which follows redirects but rejects those targeting internal/private IPs (SSRF protection). Pass True to follow all redirects without restriction.
- `max_redirects`: Maximum number of redirects. Default 30, use -1 for unlimited.
- `retries`: Number of retry attempts. Defaults to 3.
- `retry_delay`: Number of seconds to wait between retry attempts. Defaults to 1 second.
- `proxy`: Proxy URL to use. Format: "http://username:password@localhost:8030".
Cannot be used together with the `proxies` parameter.
- `proxy_auth`: HTTP basic auth for proxy in dictionary format with `username` and `password` keys.
- `auth`: HTTP basic auth in dictionary format with `username` and `password` keys.
- `verify`: Whether to verify HTTPS certificates.
- `http3`: Whether to use HTTP3. Defaults to False. It might be problematic if used it with `impersonate`.
- `stealthy_headers`: If enabled (default), it creates and adds real browser headers. It also sets a Google referer header.

<a id="scrapling.core.ai.ScraplingMCPServer.fetch"></a>

#### fetch

```python
async def fetch(url: str,
                extraction_type: extraction_types = "markdown",
                css_selector: Optional[str] = None,
                main_content_only: bool = True,
                headless: bool = True,
                google_search: bool = True,
                real_chrome: bool = False,
                wait: int | float = 0,
                proxy: Optional[str | Dict[str, str]] = None,
                timezone_id: str | None = None,
                locale: str | None = None,
                extra_headers: Optional[Dict[str, str]] = None,
                useragent: Optional[str] = None,
                cdp_url: Optional[str] = None,
                timeout: int | float = 30000,
                disable_resources: bool = False,
                wait_selector: Optional[str] = None,
                cookies: Sequence[SetCookieParam] | None = None,
                network_idle: bool = False,
                wait_selector_state: SelectorWaitStates = "attached",
                session_id: Optional[str] = None) -> ResponseModel
```

Use playwright to open a browser to fetch a URL and return a structured output of the result.

Note: This is only suitable for low-mid protection levels.
Note: If the `css_selector` resolves to more than one element, all the elements will be returned.
Note: If a `session_id` is provided (from open_session), the browser session will be reused instead of creating a new one.
    When using a session, browser-level params (headless, proxy, locale, etc.) are ignored since they were set at session creation time.

**Arguments**:

- `url`: The URL to request.
- `extraction_type`: The type of content to extract from the page. Defaults to "markdown". Options are:
- Markdown will convert the page content to Markdown format.
- HTML will return the raw HTML content of the page.
- Text will return the text content of the page.
- `css_selector`: CSS selector to extract the content from the page. If main_content_only is True, then it will be executed on the main content of the page. Defaults to None.
- `main_content_only`: Whether to extract only the main content of the page. Defaults to True. The main content here is the data inside the `<body>` tag.
- `headless`: Run the browser in headless/hidden (default), or headful/visible mode.
- `disable_resources`: Drop requests for unnecessary resources for a speed boost.
Requests dropped are of type `font`, `image`, `media`, `beacon`, `object`, `imageset`, `texttrack`, `websocket`, `csp_report`, and `stylesheet`.
- `useragent`: Pass a useragent string to be used. Otherwise the fetcher will generate a real Useragent of the same browser and use it.
- `cookies`: Set cookies for the next request. It should be in a dictionary format that Playwright accepts.
- `network_idle`: Wait for the page until there are no network connections for at least 500 ms.
- `timeout`: The timeout in milliseconds that is used in all operations and waits through the page. The default is 30,000
- `wait`: The time (milliseconds) the fetcher will wait after everything finishes before closing the page and returning the ` Response ` object.
- `wait_selector`: Wait for a specific CSS selector to be in a specific state.
- `timezone_id`: Changes the timezone of the browser. Defaults to the system timezone.
- `locale`: Specify user locale, for example, `en-GB`, `de-DE`, etc. Locale will affect navigator.language value, Accept-Language request header value as well as number and date formatting
rules. Defaults to the system default locale.
- `wait_selector_state`: The state to wait for the selector given with `wait_selector`. The default state is `attached`.
- `real_chrome`: If you have a Chrome browser installed on your device, enable this, and the Fetcher will launch an instance of your browser and use it.
- `cdp_url`: Instead of launching a new browser instance, connect to this CDP URL to control real browsers through CDP.
- `google_search`: Enabled by default, Scrapling will set a Google referer header.
- `extra_headers`: A dictionary of extra headers to add to the request. _The referer set by `google_search` takes priority over the referer set here if used together._
- `proxy`: The proxy to be used with requests, it can be a string or a dictionary with the keys 'server', 'username', and 'password' only.
- `session_id`: Optional session ID from open_session. If provided, reuses the existing browser session instead of creating a new one.

<a id="scrapling.core.ai.ScraplingMCPServer.bulk_fetch"></a>

#### bulk\_fetch

```python
async def bulk_fetch(urls: List[str],
                     extraction_type: extraction_types = "markdown",
                     css_selector: Optional[str] = None,
                     main_content_only: bool = True,
                     headless: bool = True,
                     google_search: bool = True,
                     real_chrome: bool = False,
                     wait: int | float = 0,
                     proxy: Optional[str | Dict[str, str]] = None,
                     timezone_id: str | None = None,
                     locale: str | None = None,
                     extra_headers: Optional[Dict[str, str]] = None,
                     useragent: Optional[str] = None,
                     cdp_url: Optional[str] = None,
                     timeout: int | float = 30000,
                     disable_resources: bool = False,
                     wait_selector: Optional[str] = None,
                     cookies: Sequence[SetCookieParam] | None = None,
                     network_idle: bool = False,
                     wait_selector_state: SelectorWaitStates = "attached",
                     session_id: Optional[str] = None) -> List[ResponseModel]
```

Use playwright to open a browser, then fetch a group of URLs at the same time, and for each page return a structured output of the result.

Note: This is only suitable for low-mid protection levels.
Note: If the `css_selector` resolves to more than one element, all the elements will be returned.
Note: If a `session_id` is provided (from open_session), the browser session will be reused instead of creating a new one.
    When using a session, browser-level params (headless, proxy, locale, etc.) are ignored since they were set at session creation time.

**Arguments**:

- `urls`: A list of the URLs to request.
- `extraction_type`: The type of content to extract from the page. Defaults to "markdown". Options are:
- Markdown will convert the page content to Markdown format.
- HTML will return the raw HTML content of the page.
- Text will return the text content of the page.
- `css_selector`: CSS selector to extract the content from the page. If main_content_only is True, then it will be executed on the main content of the page. Defaults to None.
- `main_content_only`: Whether to extract only the main content of the page. Defaults to True. The main content here is the data inside the `<body>` tag.
- `headless`: Run the browser in headless/hidden (default), or headful/visible mode.
- `disable_resources`: Drop requests for unnecessary resources for a speed boost.
Requests dropped are of type `font`, `image`, `media`, `beacon`, `object`, `imageset`, `texttrack`, `websocket`, `csp_report`, and `stylesheet`.
- `useragent`: Pass a useragent string to be used. Otherwise the fetcher will generate a real Useragent of the same browser and use it.
- `cookies`: Set cookies for the next request. It should be in a dictionary format that Playwright accepts.
- `network_idle`: Wait for the page until there are no network connections for at least 500 ms.
- `timeout`: The timeout in milliseconds that is used in all operations and waits through the page. The default is 30,000
- `wait`: The time (milliseconds) the fetcher will wait after everything finishes before closing the page and returning the ` Response ` object.
- `wait_selector`: Wait for a specific CSS selector to be in a specific state.
- `timezone_id`: Changes the timezone of the browser. Defaults to the system timezone.
- `locale`: Specify user locale, for example, `en-GB`, `de-DE`, etc. Locale will affect navigator.language value, Accept-Language request header value as well as number and date formatting
rules. Defaults to the system default locale.
- `wait_selector_state`: The state to wait for the selector given with `wait_selector`. The default state is `attached`.
- `real_chrome`: If you have a Chrome browser installed on your device, enable this, and the Fetcher will launch an instance of your browser and use it.
- `cdp_url`: Instead of launching a new browser instance, connect to this CDP URL to control real browsers through CDP.
- `google_search`: Enabled by default, Scrapling will set a Google referer header.
- `extra_headers`: A dictionary of extra headers to add to the request. _The referer set by `google_search` takes priority over the referer set here if used together._
- `proxy`: The proxy to be used with requests, it can be a string or a dictionary with the keys 'server', 'username', and 'password' only.
- `session_id`: Optional session ID from open_session. If provided, reuses the existing browser session instead of creating a new one.

<a id="scrapling.core.ai.ScraplingMCPServer.stealthy_fetch"></a>

#### stealthy\_fetch

```python
async def stealthy_fetch(url: str,
                         extraction_type: extraction_types = "markdown",
                         css_selector: Optional[str] = None,
                         main_content_only: bool = True,
                         headless: bool = True,
                         google_search: bool = True,
                         real_chrome: bool = False,
                         wait: int | float = 0,
                         proxy: Optional[str | Dict[str, str]] = None,
                         timezone_id: str | None = None,
                         locale: str | None = None,
                         extra_headers: Optional[Dict[str, str]] = None,
                         useragent: Optional[str] = None,
                         hide_canvas: bool = False,
                         cdp_url: Optional[str] = None,
                         timeout: int | float = 30000,
                         disable_resources: bool = False,
                         wait_selector: Optional[str] = None,
                         cookies: Sequence[SetCookieParam] | None = None,
                         network_idle: bool = False,
                         wait_selector_state: SelectorWaitStates = "attached",
                         block_webrtc: bool = False,
                         allow_webgl: bool = True,
                         solve_cloudflare: bool = False,
                         additional_args: Optional[Dict] = None,
                         session_id: Optional[str] = None) -> ResponseModel
```

Use the stealthy fetcher to fetch a URL and return a structured output of the result.

Note: This is the only suitable fetcher for high protection levels.
Note: If the `css_selector` resolves to more than one element, all the elements will be returned.
Note: If a `session_id` is provided (from open_session), the browser session will be reused instead of creating a new one.
    When using a session, browser-level params (headless, proxy, locale, etc.) are ignored since they were set at session creation time.

**Arguments**:

- `url`: The URL to request.
- `extraction_type`: The type of content to extract from the page. Defaults to "markdown". Options are:
- Markdown will convert the page content to Markdown format.
- HTML will return the raw HTML content of the page.
- Text will return the text content of the page.
- `css_selector`: CSS selector to extract the content from the page. If main_content_only is True, then it will be executed on the main content of the page. Defaults to None.
- `main_content_only`: Whether to extract only the main content of the page. Defaults to True. The main content here is the data inside the `<body>` tag.
- `headless`: Run the browser in headless/hidden (default), or headful/visible mode.
- `disable_resources`: Drop requests for unnecessary resources for a speed boost.
Requests dropped are of type `font`, `image`, `media`, `beacon`, `object`, `imageset`, `texttrack`, `websocket`, `csp_report`, and `stylesheet`.
- `useragent`: Pass a useragent string to be used. Otherwise the fetcher will generate a real Useragent of the same browser and use it.
- `cookies`: Set cookies for the next request.
- `solve_cloudflare`: Solves all types of the Cloudflare's Turnstile/Interstitial challenges before returning the response to you.
- `allow_webgl`: Enabled by default. Disabling WebGL is not recommended as many WAFs now check if WebGL is enabled.
- `network_idle`: Wait for the page until there are no network connections for at least 500 ms.
- `wait`: The time (milliseconds) the fetcher will wait after everything finishes before closing the page and returning the ` Response ` object.
- `timeout`: The timeout in milliseconds that is used in all operations and waits through the page. The default is 30,000
- `wait_selector`: Wait for a specific CSS selector to be in a specific state.
- `timezone_id`: Changes the timezone of the browser. Defaults to the system timezone.
- `locale`: Specify user locale, for example, `en-GB`, `de-DE`, etc. Locale will affect navigator.language value, Accept-Language request header value as well as number and date formatting
rules. Defaults to the system default locale.
- `wait_selector_state`: The state to wait for the selector given with `wait_selector`. The default state is `attached`.
- `real_chrome`: If you have a Chrome browser installed on your device, enable this, and the Fetcher will launch an instance of your browser and use it.
- `hide_canvas`: Add random noise to canvas operations to prevent fingerprinting.
- `block_webrtc`: Forces WebRTC to respect proxy settings to prevent local IP address leak.
- `cdp_url`: Instead of launching a new browser instance, connect to this CDP URL to control real browsers through CDP.
- `google_search`: Enabled by default, Scrapling will set a Google referer header.
- `extra_headers`: A dictionary of extra headers to add to the request. _The referer set by `google_search` takes priority over the referer set here if used together._
- `proxy`: The proxy to be used with requests, it can be a string or a dictionary with the keys 'server', 'username', and 'password' only.
- `additional_args`: Additional arguments to be passed to Playwright's context as additional settings, and it takes higher priority than Scrapling's settings.
- `session_id`: Optional session ID from open_session. If provided, reuses the existing browser session instead of creating a new one.

<a id="scrapling.core.ai.ScraplingMCPServer.bulk_stealthy_fetch"></a>

#### bulk\_stealthy\_fetch

```python
async def bulk_stealthy_fetch(
        urls: List[str],
        extraction_type: extraction_types = "markdown",
        css_selector: Optional[str] = None,
        main_content_only: bool = True,
        headless: bool = True,
        google_search: bool = True,
        real_chrome: bool = False,
        wait: int | float = 0,
        proxy: Optional[str | Dict[str, str]] = None,
        timezone_id: str | None = None,
        locale: str | None = None,
        extra_headers: Optional[Dict[str, str]] = None,
        useragent: Optional[str] = None,
        hide_canvas: bool = False,
        cdp_url: Optional[str] = None,
        timeout: int | float = 30000,
        disable_resources: bool = False,
        wait_selector: Optional[str] = None,
        cookies: Sequence[SetCookieParam] | None = None,
        network_idle: bool = False,
        wait_selector_state: SelectorWaitStates = "attached",
        block_webrtc: bool = False,
        allow_webgl: bool = True,
        solve_cloudflare: bool = False,
        additional_args: Optional[Dict] = None,
        session_id: Optional[str] = None) -> List[ResponseModel]
```

Use the stealthy fetcher to fetch a group of URLs at the same time, and for each page return a structured output of the result.

Note: This is the only suitable fetcher for high protection levels.
Note: If the `css_selector` resolves to more than one element, all the elements will be returned.
Note: If a `session_id` is provided (from open_session), the browser session will be reused instead of creating a new one.
    When using a session, browser-level params (headless, proxy, locale, etc.) are ignored since they were set at session creation time.

**Arguments**:

- `urls`: A list of the URLs to request.
- `extraction_type`: The type of content to extract from the page. Defaults to "markdown". Options are:
- Markdown will convert the page content to Markdown format.
- HTML will return the raw HTML content of the page.
- Text will return the text content of the page.
- `css_selector`: CSS selector to extract the content from the page. If main_content_only is True, then it will be executed on the main content of the page. Defaults to None.
- `main_content_only`: Whether to extract only the main content of the page. Defaults to True. The main content here is the data inside the `<body>` tag.
- `headless`: Run the browser in headless/hidden (default), or headful/visible mode.
- `disable_resources`: Drop requests for unnecessary resources for a speed boost.
Requests dropped are of type `font`, `image`, `media`, `beacon`, `object`, `imageset`, `texttrack`, `websocket`, `csp_report`, and `stylesheet`.
- `useragent`: Pass a useragent string to be used. Otherwise the fetcher will generate a real Useragent of the same browser and use it.
- `cookies`: Set cookies for the next request.
- `solve_cloudflare`: Solves all types of the Cloudflare's Turnstile/Interstitial challenges before returning the response to you.
- `allow_webgl`: Enabled by default. Disabling WebGL is not recommended as many WAFs now check if WebGL is enabled.
- `network_idle`: Wait for the page until there are no network connections for at least 500 ms.
- `wait`: The time (milliseconds) the fetcher will wait after everything finishes before closing the page and returning the ` Response ` object.
- `timeout`: The timeout in milliseconds that is used in all operations and waits through the page. The default is 30,000
- `wait_selector`: Wait for a specific CSS selector to be in a specific state.
- `timezone_id`: Changes the timezone of the browser. Defaults to the system timezone.
- `locale`: Specify user locale, for example, `en-GB`, `de-DE`, etc. Locale will affect navigator.language value, Accept-Language request header value as well as number and date formatting
rules. Defaults to the system default locale.
- `wait_selector_state`: The state to wait for the selector given with `wait_selector`. The default state is `attached`.
- `real_chrome`: If you have a Chrome browser installed on your device, enable this, and the Fetcher will launch an instance of your browser and use it.
- `hide_canvas`: Add random noise to canvas operations to prevent fingerprinting.
- `block_webrtc`: Forces WebRTC to respect proxy settings to prevent local IP address leak.
- `cdp_url`: Instead of launching a new browser instance, connect to this CDP URL to control real browsers through CDP.
- `google_search`: Enabled by default, Scrapling will set a Google referer header.
- `extra_headers`: A dictionary of extra headers to add to the request. _The referer set by `google_search` takes priority over the referer set here if used together._
- `proxy`: The proxy to be used with requests, it can be a string or a dictionary with the keys 'server', 'username', and 'password' only.
- `additional_args`: Additional arguments to be passed to Playwright's context as additional settings, and it takes higher priority than Scrapling's settings.
- `session_id`: Optional session ID from open_session. If provided, reuses the existing browser session instead of creating a new one.

<a id="scrapling.core.ai.ScraplingMCPServer.serve"></a>

#### serve

```python
def serve(http: bool, host: str, port: int)
```

Serve the MCP server.

