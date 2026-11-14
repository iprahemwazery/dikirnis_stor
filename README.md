# Dikirnis Store

A Flutter application for a local services directory and marketplace in
Dikirnis, Egypt. The app is Arabic-first with English support and automatic RTL
layout.

## Features

- Home screen with banners, featured advertisements, categories, and business
  sections.
- Explore screen for browsing service categories.
- Original Offers screen with a one-column offer list, search, category
  filtering, and favorites.
- Marketplace screen with a two-column product layout, search, category
  filtering, sorting, and favorites.
- Rich product details with image gallery, pricing, seller information, AI
  guidance preview, comments preview, similar products, and unavailable-state
  actions.
- Profile screen backed by preview data.
- Persistent settings for Arabic/English language and system/light/dark theme.
- Persistent favorites that survive app restarts.
- Arabic and English localization generated from ARB files.
- Loading, empty, error, retry, refresh, and unavailable states.
- Guarded shell navigation with per-tab state preservation and back-to-home
  behavior.

All content currently comes from bundled preview JSON and local image assets.
No production backend or credentials are included.

## Screens and navigation

| Index | Destination | Route |
| --- | --- | --- |
| 0 | Home | `/` |
| 1 | Explore | `/explore` |
| 2 | Marketplace | `/marketplace` |
| 3 | Offers | `/offers` |
| 4 | Profile | `/profile` |

Product details use `/marketplace/:offerId`; original offer details use
`/offers/:offerId`.

## Prerequisites

- Flutter compatible with Dart `^3.11.5`.
- A configured target such as Android, iOS, web, or desktop.
- Android builds require accepted Android SDK licenses.

Check the environment with:

```bash
flutter --version
flutter doctor
flutter devices
```

## Getting started

```bash
flutter pub get
flutter gen-l10n
flutter run
```

Useful targets:

```bash
flutter run -d chrome
flutter run -d linux
```

The app works without a backend because all current datasources are local
preview implementations.

## Architecture

The project uses practical Clean Architecture with a feature-first layout.

```text
lib/
  main.dart                         Application entry point
  app/                              Root MaterialApp and composition
  router/                           go_router configuration and route constants
  theme/                            Colors, spacing, radii, shadows, typography
  l10n/                             ARB sources and generated localizations
  core/
    config/                         Build-time application configuration
    di/                             get_it registrations
    errors/                         Exceptions, failures, and mapping
    network/                        Dio client and error translation
    widgets/                        Shared UI widgets
  features/
    categories/                     Category data, domain, and Explore screen
    home/                           Home content, business cards, and banners
    offers/                         Offers, Marketplace, product details, favorites
    profile/                        Profile data and screen
    settings/                       Language/theme settings and persistence
test/                               Unit, Cubit, repository, model, and widget tests
```

Layer responsibilities:

- **Presentation** contains pages, feature widgets, Cubits, and immutable
  states. It does not perform HTTP calls or persistence directly.
- **Domain** contains entities and repository contracts without Flutter or
  transport dependencies.
- **Data** contains models, datasources, and repository implementations.
- **Core** contains shared infrastructure and reusable UI.

## State management conventions

- Every feature state is immutable and extends `Equatable`.
- Cubits check `isClosed` after asynchronous work before emitting.
- Duplicate loads are ignored while a request is in flight; reloading requires
  an explicit `force` or `refresh`.
- Catalog requests are cached briefly, deduplicated, and can fall back to stale
  data when an offline refresh fails.
- Outdated detail responses are ignored when a newer offer request completes.
- Errors are mapped to `AppFailure`, while user-facing messages remain
  localized in the presentation layer.
- Cubits are created with `BlocProvider` and disposed by the widget tree.

## Dependency injection

`configureDependencies()` in `lib/core/di/injection.dart` runs before
`runApp`. Repositories and infrastructure are lazy singletons; Cubits are
factories so each screen owns and disposes its instance.

## Data and actions

Preview datasources provide:

- Home banners, advertisements, categories, and businesses.
- Service categories.
- Offers with prices, galleries, sellers, comments, availability, and
  publication metadata.
- User profile information.

The following actions intentionally show unavailable states because no backend
contract exists yet:

- Placing orders.
- Adding comments.
- Calling or messaging sellers.
- Publishing products.

Favorites and display settings are persisted locally with SharedPreferences.

## Environment configuration

The API base URL is supplied at build time and is never committed:

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com/v1
```

`AppConfig.apiBaseUrl` is empty by default, so no invented production endpoint
is called. Never place secrets, private API keys, or production credentials in
the repository.

## Generated code

Do not edit generated files by hand.

```bash
flutter gen-l10n
dart run build_runner build
```

Generated outputs:

- `lib/l10n/generated/`
- `lib/features/**/data/models/*.g.dart`

If build_runner reports stale outputs:

```bash
dart run build_runner clean
dart run build_runner build
```

## Testing and quality

```bash
dart format lib test
flutter analyze
flutter test
flutter build apk --debug
```

Verified on the current codebase:

- `flutter analyze`: no issues.
- `flutter test`: 105 tests passed.
- `flutter build apk --debug`: successful.
- Debug APK installed and launched on an Android device.

## Known limitations

- Backend, authentication, database, and API contracts are not defined.
- All datasources are preview implementations.
- Orders, comments, seller contact, and product publishing are unavailable
  until their services are connected.
- Catalog caching is in-memory only; there is no durable offline catalog or
  remote-image cache.
- Pagination and server-side search/sorting are not implemented.
- Automated coverage is unit, Cubit, repository, and widget tests; there is no
  device integration-test suite.
- There is no CI pipeline or release signing configuration.
- Release builds and store submission still require production configuration.

## Project conventions

1. Keep features in `lib/features/<feature>/` with `data`, `domain`, and
   `presentation` only where each layer is needed.
2. Add entities and repository contracts in `domain`.
3. Add models, datasources, and repository implementations in `data`.
4. Add Cubits with explicit loading, success, empty, and failure handling.
5. Register dependencies in `injection.dart` in dependency order.
6. Add routes in `app_router.dart` and provide Cubits with `BlocProvider`.
7. Add localization keys to both ARB files and run `flutter gen-l10n`.
8. Reuse shared widgets and theme tokens rather than hardcoded values.
9. Add Cubit, repository, and widget tests, then run format, analyze, and test.
