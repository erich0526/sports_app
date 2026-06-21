# 🏆 Sports App

A Flutter mobile application for managing sports matches and player statistics, built with Clean Architecture and BLoC state management.

---

## 技術棧 Tech Stack

| 類別 | 技術 |
|------|------|
| Framework | Flutter (Dart) |
| Architecture | Clean Architecture · Feature-first |
| State Management | flutter_bloc |
| Dependency Injection | get_it |
| Database | Firebase Firestore |
| Version Control | GitHub Flow |

---

## 專案架構 Architecture

本專案採用 **Clean Architecture** 搭配 **Feature-first** 資料夾組織。

### 核心原則

依賴方向只能由外往內，`domain` 層為核心，不依賴任何外部框架：

```
presentation  ──→  domain  ←──  data
   (BLoC)        (純 Dart)    (Firestore)
```

- `presentation`：呼叫 domain 的 UseCase，負責 UI 與狀態管理
- `domain`：定義 Entity、UseCase、Repository interface，無任何外部依賴
- `data`：實作 Repository interface，負責與 Firebase 溝通

### Feature 區分方式

以**功能模組（functional domain）** 為單位區分，目前包含兩個 feature：

| Feature | 說明 |
|---------|------|
| `match` | 賽事列表、新增賽事、賽事詳情 |
| `player` | 球員列表、個人頁面、數據統計與評估 |

每個 feature 各自獨立，包含完整的 data / domain / presentation 三層，修改其中一個不影響另一個。

---

## 資料夾結構 Folder Structure

```
lib/
├── core/
│   ├── error/
│   │   └── failure.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── injection_container.dart   # GetIt 所有依賴登記
│
├── features/
│   ├── match/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── match_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── match_model.dart
│   │   │   └── repositories/
│   │   │       └── match_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── match.dart
│   │   │   ├── repositories/
│   │   │   │   └── match_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_matches.dart
│   │   │       └── add_match.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── match_bloc.dart
│   │       │   ├── match_event.dart
│   │       │   └── match_state.dart
│   │       └── pages/
│   │           ├── match_list_page.dart
│   │           └── add_match_page.dart
│   │
│   └── player/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── player_remote_datasource.dart
│       │   ├── models/
│       │   │   └── player_model.dart
│       │   └── repositories/
│       │       └── player_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── player.dart
│       │   ├── repositories/
│       │   │   └── player_repository.dart
│       │   └── usecases/
│       │       ├── get_player_stats.dart
│       │       └── evaluate_player.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── player_bloc.dart
│           │   ├── player_event.dart
│           │   └── player_state.dart
│           └── pages/
│               ├── player_list_page.dart
│               └── player_profile_page.dart
│
└── main.dart
```

---

## 功能說明 Features

### 賽事管理 Match Management
- 瀏覽所有賽事列表
- 新增賽事（日期、對戰隊伍、比分）
- 資料即時同步至 Firebase Firestore

### 球員管理 Player Management
- 瀏覽球員列表
- 球員個人頁面（基本資料、照片）
- 數據統計（出賽場次、進球、助攻）
- 綜合表現評估（自訂加權公式）

---

## 如何執行 Getting Started

### 環境需求

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Firebase 專案（Firestore 已啟用）

### 安裝步驟

1. Clone 此 repo：

```bash
git clone https://github.com/your-username/sports-app.git
cd sports-app
```

2. 安裝套件：

```bash
flutter pub get
```

3. 設定 Firebase：

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

4. 執行 App：

```bash
flutter run
```

---

## 開發流程 GitHub Flow

本專案遵循 **GitHub Flow**：

```
main（永遠可執行）
  ├── feature/match-domain-data
  ├── feature/match-presentation
  ├── feature/player-domain-data
  └── feature/player-presentation
```

- `main` branch 永遠保持可正常執行的狀態
- 每個功能在獨立的 feature branch 開發
- 完成後開 Pull Request，review 通過後 merge 回 main
- Commit message 遵循 [Conventional Commits](https://www.conventionalcommits.org/)

### Commit Message 格式

```
feat(match): add GetMatches use case and Firestore implementation
fix(player): correct stats calculation for empty match list
refactor(core): extract BaseUseCase to reduce boilerplate
docs(readme): update folder structure section
```

---

## 依賴套件 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  get_it: ^7.6.4
  firebase_core: ^2.24.2
  cloud_firestore: ^4.14.0
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.5
```

---

## License

MIT
