# 📚 MyBooks - Flutter App

MyBooks is a Flutter application that displays a list of books fetched from the Open Library API. It allows users to:

- Browse books with pagination
- View detailed information about each book
- Mark/unmark books as favourite
- View a list of their favourite books
- Persist favourites using `SharedPreferences` across app launches

---

## 🚀 Getting Started

### 🔧 Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.10 or higher recommended)
- Android Studio or Visual Studio Code
- An emulator or a physical device

---

### ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/mybooks_app.git
   cd mybooks_app

2. Install dependencies

flutter pub get

3.Run the app

    flutter run

🏗️ Architecture

The app is built using Clean Architecture principles and BLoC (Business Logic Component) for state management.
Layered Architecture Overview

lib/
├── core/                     # Core utilities, constants, failure handling
├── data/                     # Data layer: Models, RemoteDataSource
├── domain/                   # Domain layer: Entities, Repository abstraction, UseCases
├── presentation/             # UI and BLoC state management
├── services/                 # SharedPreferences for persistence

Key Decisions

    State Management: We used BLoC for predictable state handling and to maintain a clear separation of concerns.

    Persistence: SharedPreferences was used to persist user's favourite books across app launches.

    API Integration: Books are fetched using the Open Library’s API and displayed in a paginated list.

    Entity Conversion: We keep the domain layer clean by converting models to entities using a .toEntity() method.

💾 SharedPreferences

We store the key (unique ID) of favourite books locally using SharedPreferences. When the app is re-opened, the stored keys are matched with the incoming list of books to restore favourite status.
















