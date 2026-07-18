# AI-HUB (Orange AI Hub)

A Flutter app, built with [FlutterFlow](https://flutterflow.io), for chatting
with and comparing AI models (Gemini, and others via API). Includes Firebase
auth, analytics, and Cloud Functions.

## Project layout

- `lib/` — the Flutter app source code
  - `lib/pages/` — the app's screens (chat, model comparison, settings, …)
  - `lib/components/` — reusable UI pieces (chat bubble, model card, …)
  - `lib/backend/gemini/` — calls to the Gemini API
  - `lib/flutter_flow/` — FlutterFlow's utility/framework layer
- `test/` — unit tests (run with `flutter test`)
- `firebase/` — Firebase config, security rules, and Cloud Functions
- `flutterflow/` — FlutterFlow project configuration YAMLs (for reference)

## Running the app

The Gemini API key is **not** stored in the code. Supply it at build time
with a `--dart-define` flag:

```sh
flutter pub get
flutter run --dart-define=GEMINI_API_KEY=your-key-here
```

Never commit an API key to the repository.

## Running the tests

```sh
flutter test
```
