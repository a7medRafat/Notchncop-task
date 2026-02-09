# 🎬 TMDB Flutter App

A clean, production-ready Flutter application that consumes **The Movie Database (TMDB) API**, built with scalable architecture, proper dependency injection, offline handling, pagination, favorites, and secure environment configuration.

---

## How to Set Up & Run the App

### 1️⃣ Prerequisites
- Make sure you have:
- Flutter stable (3.x+)
- Dart 3.x
- Android Studio / VS Code
- A TMDB Read Access Token (Bearer)

2️⃣ Clone the Repository
git clone https://github.com/<your-username>/tmdb_app.git
cd tmdb_app

3️⃣ Configure Environment (IMPORTANT)
This project does NOT hardcode secrets.
Create the file: android/local.properties
Add the following:

.env.dev
.env.prod

#### .env.dev
TMDB_BEARER=YOUR_TMDB_READ_ACCESS_TOKEN
TMDB_BASE_URL=https://api.themoviedb.org/3
TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p

#### .env.prod
TMDB_BEARER=YOUR_TMDB_READ_ACCESS_TOKEN
TMDB_BASE_URL=https://api.themoviedb.org/3
TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p

Add to .gitignore:
.env*

⚠️ local.properties is ignored by git and should never be committed.

---

## Running the App

### Android
flutter run --flavor dev

Android uses local.properties + Gradle dart-defines for secrets.

### iOS
flutter run --dart-define=ENV=dev

Or from Xcode:
- Open ios/Runner.xcworkspace
- Select Runner-Dev
- Press Run

---

## Architecture Overview

The app follows Clean Architecture principles with strict separation of concerns.

lib/
├── core/
│   ├── config/        # Env, API URLs, app constants
│   ├── di/            # get_it dependency injection
│   ├── network/       # Dio client, interceptors, connectivity
│   └── utils/         # Extensions, helpers
│
├── features/
│   ├── movies/
│   │   ├── data/      # DTOs, Retrofit APIs, repositories impl
│   │   ├── domain/    # Entities, repositories, use cases
│   │   └── presentation/
│   │       ├── cubit/ # State management
│   │       ├── screens/
│   │       └── widgets/
│   └── favorites/
│
└── main.dart


---

## Key Technical Decisions

State Management: Bloc / Cubit  
Dependency Injection: get_it  
Networking: Dio + Retrofit  
Local Storage: SharedPreferences  
Pagination: Infinite scroll with prefetch  
Offline Handling: Connectivity check + graceful errors

---

## Features

- Popular movies (paginated)
- Movie details screen
- Favorites persistence
- Offline & error handling
- Skeleton loaders
- Grid-based modern UI
- Secure API handling

---

## 🔐 Security Notes

- No API keys committed
- Secrets injected via env / Gradle / Xcode
- .env ignored by Git


---

Built with ❤️ using Flutter.
