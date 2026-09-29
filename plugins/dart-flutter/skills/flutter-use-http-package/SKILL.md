---
name: flutter-use-http-package
description: Use package:http for Flutter REST requests. Use for request construction, response validation, JSON decoding, client injection, and network tests.
---

# Use HTTP in Flutter

## Implement requests

Add `http` if needed and use `Uri` to build URLs and query parameters. Inject an `http.Client` for reusable services so tests can supply a mock client. Close a client that the service owns.

Set headers and encode JSON bodies for the API contract. Check the documented success status for each operation; successful responses can include 200, 201, or 204. Do not decode an empty response body. Include status and safe response context in failures without exposing credentials. Avoid unconditional `dart:io` imports in code that must compile for Flutter web.

Decode into typed models with checked casts or patterns. Move expensive parsing off the UI isolate when measurements or payload size justify it; keep small payloads simple. Use the app's existing state-management approach. `FutureBuilder` is an option for a suitable one-shot request, not a required wrapper for every request.

## Verify

Test request method, URI, headers, success and error responses, and JSON shape with a controlled client. Verify platform permissions only for platforms the app targets. Do not add a live token or real API call to an example test.
