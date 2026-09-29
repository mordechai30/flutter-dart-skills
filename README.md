# Flutter Agent Plugins

Agent plugins for Flutter, maintained by the Flutter team.

A collection of plugins designed to extend AI agent capabilities for Flutter development. These plugins bundle together skills, MCP server configuration, and rules to provide tailored workflows and instructions for happy path Flutter development. By giving the agent domain expertise and repeatable workflows, you drastically reduce mistakes and ensure agents reliably complete tasks following best practices.

Plugins can package various customizations together. A key component of these plugins is **Agent Skills**, which are simple folders of files that can be seen as complementary to MCP: where MCP gives an agent access to specialized tools, a Skill teaches the agent “how” to use tools for a specific task.

The packaged Codex plugin includes the Dart skills synced from [dart-lang/skills](https://github.com/dart-lang/skills).

## Installation

Refer to [Get started developing with AI](https://docs.flutter.dev/ai/get-started) for detailed instructions on how to install the plugins for your preferred agent.

The Codex plugin configures the local Dart and Flutter MCP server. The [hot reload rule](rules/flutter-hot-reload.md) and [Cursor rule](rules/flutter-hot-reload.mdc) are separate project instructions; Codex does not load them from the plugin automatically. The [Developer Knowledge MCP server](https://developers.google.com/knowledge/mcp) provides optional online documentation search. Package-specific skills can be installed with [package:skills](https://dart.dev/ai/package-skills).

## Available Skills

| Skill | Description | Example prompt |
|---|---|---|
| [flutter-add-integration-test](skills/flutter-add-integration-test/SKILL.md) | Add and run Flutter integration tests with integration_test. Use for device-level app flows, platform behavior, and end-to-end interactions. | Add an integration test that validates the checkout experience |
| [flutter-add-widget-preview](skills/flutter-add-widget-preview/SKILL.md) | Add Flutter Widget Previews to inspect UI components in isolation. Use when previewing widgets on a compatible Flutter SDK. | Create a preview for the ProductCard widget with different price states |
| [flutter-add-widget-test](skills/flutter-add-widget-test/SKILL.md) | Implement a component-level test using `WidgetTester` to verify UI rendering and user interactions (tapping, scrolling, entering text). Use when validating that a specific widget displays correct data and responds to events as expected. | Add a widget test for the CustomButton to verify the onTap callback is called |
| [flutter-apply-architecture-best-practices](skills/flutter-apply-architecture-best-practices/SKILL.md) | Structure or refactor Flutter features with clear UI, state, and data boundaries. Use for requested architecture work or a concrete separation problem. | Refactor the authentication flow to follow the recommended layered architecture |
| [flutter-build-responsive-layout](skills/flutter-build-responsive-layout/SKILL.md) | Use `LayoutBuilder`, `MediaQuery`, or `Expanded/Flexible` to create a layout that adapts to different screen sizes. Use when you need the UI to look good on both mobile and tablet/desktop form factors. | Make the home screen responsive so it displays a grid on tablets and a list on phones |
| [flutter-fix-layout-issues](skills/flutter-fix-layout-issues/SKILL.md) | Fixes Flutter layout errors (overflows, unbounded constraints) using Dart and Flutter MCP tools. Use when addressing "RenderFlex overflowed", "Vertical viewport was given unbounded height", or similar layout issues. | Fix the overflow error on the profile page when the keyboard is visible |
| [flutter-implement-json-serialization](skills/flutter-implement-json-serialization/SKILL.md) | Create model classes with `fromJson` and `toJson` methods using `dart:convert`. Use when manually mapping JSON keys to class properties for simple data structures. | Implement JSON serialization for the User model class |
| [flutter-setup-declarative-routing](skills/flutter-setup-declarative-routing/SKILL.md) | Set up or update declarative Flutter navigation, URLs, deep links, and nested routes. | Set up GoRouter with paths for home, details, and settings |
| [flutter-setup-localization](skills/flutter-setup-localization/SKILL.md) | Set up or update generated Flutter localizations from ARB files, including delegates and locale lists. | Setup localization and add English and Spanish translations |
| [flutter-use-http-package](skills/flutter-use-http-package/SKILL.md) | Use package:http for Flutter REST requests, response validation, JSON decoding, and network tests. | Use the http package to fetch the list of products from the API |

## Contributing

We aren't accepting pull requests at this time, but we would love to hear your feedback! 

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## Code of Conduct

Please see [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for more information.
