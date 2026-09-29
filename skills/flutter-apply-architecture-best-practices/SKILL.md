---
name: flutter-apply-architecture-best-practices
description: Structure or refactor Flutter features with clear UI, state, and data boundaries. Use when the user requests architecture work or an existing feature has a concrete separation problem.
---

# Structure Flutter features

Inspect the app's existing state-management and dependency conventions. Preserve them unless the task calls for a migration. Keep widgets focused on presentation and interaction; move reusable business rules and I/O behind testable boundaries where complexity justifies it.

A view, view model, repository, and service split is one useful option. Add a domain or use-case layer only when it simplifies shared or complex business logic. Do not require `ChangeNotifier`, `freezed`, `built_value`, `provider`, `get_it`, or a dependency-injection container for every feature.

For a refactor, keep external behavior stable. Verify the affected state transitions and data behavior with focused tests, then run analysis and relevant widget tests.
