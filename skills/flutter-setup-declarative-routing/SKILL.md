---
name: flutter-setup-declarative-routing
description: Set up or update declarative Flutter navigation, URLs, deep links, and nested routes. Use when an app needs browser history, route state, or platform deep links.
---

# Set up declarative routing

Inspect the current router, Flutter version, design-library imports, URL strategy, and target platforms. Preserve an existing router unless the task calls for a migration. `go_router` is a common choice for route trees, redirects, and parallel navigation branches; add it only when it fits the app.

Use `MaterialApp.router` or the app's equivalent router constructor. In Flutter 3.47, standalone `material_ui` and `cupertino_ui` are opt-in; use imports that match the app's chosen UI stack. Do not migrate design packages just to add routing.

Model route paths and parameters explicitly. Use `StatefulShellRoute` when parallel branches must retain their navigation stacks. Handle unknown locations and redirect loops. Configure web URL strategy and Android or iOS link associations only for requested target platforms and domains.

Test direct entry to a deep link, browser back or app back, redirects, and branch state on each relevant platform. Verify platform association files are hosted at the correct domain before claiming links work outside the app.
