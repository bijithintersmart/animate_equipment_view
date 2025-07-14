# 🧭 Animated TabView Grid/List for Flutter

`animate_equipment_view` is a Flutter package that provides a beautiful and responsive animated tab view with support for **grid and list layouts**, and **smooth local hero-style transitions** using a nested `Navigator`.

---

## ✨ Features

- 🗂️ Tab-based navigation
- 🔁 Switch between Grid and List view
- 💫 Animated page transitions using `LocalHero`
- 🎨 Customizable transition duration and design size
- ⚡ Optimized for performance with nested `Navigator`
- 🧱 Designed for responsive layouts using `flutter_screenutil`

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  animate_equipment_view: ^1.0.0
````

Then run:

```bash
flutter pub get
```

---

## 🚀 Getting Started

### Import the package

```dart
import 'package:animate_equipment_view/animate_equipment_view.dart';
```

---

## 🧩 Usage

```dart
class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated TabView'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Grid'),
            Tab(text: 'List'),
          ],
        ),
      ),
      body: LocalHero(
        controller: _tabController,
        pages: [
          GridViewWidget(),
          ListViewWidget(),
         
        ],
      ),
    );
  }
}
```

---

## ⚙️ `LocalHero` Properties

| Property             | Type            | Description                                                 |
| -------------------- | --------------- | ----------------------------------------------------------- |
| `pages`              | `List<Widget>`  | Required. Pages to show per tab.                            |
| `controller`         | `TabController` | Required. Manages the selected tab.                         |
| `transitionDuration` | `Duration?`     | Optional. Controls animation speed. Default is `1100ms`.    |
| `designSize`         | `Size?`         | Optional. Used for screen scaling via `flutter_screenutil`. |

---

## 🧪 Example Project

To run the example:

```bash
git clone https://github.com/yourusername/animate_equipment_view.git
cd example
flutter run
```

---

## 📸 Screenshots

| Grid View | List View |
|-----------|-----------|
| ![](https://example.com/grid.gif) | ![](https://example.com/list.gif) |

---

## 🔧 Dependencies

- `flutter_screenutil`: For responsive layout
- Uses `Navigator`, `PageRouteBuilder`, and `SlideTransition` internally

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
