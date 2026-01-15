# 🔒 Secure Expense Tracker

A local-first, privacy-focused mobile finance application built with **Flutter**. This app allows users to track income and expenses with visual analytics, data persistence via SQLite, and biometric security layers.

> **Status:** MVP Complete (v1.0)
> **Platform:** Android (Primary), iOS (Compatible)

## 🚀 Key Features

* **📊 Visual Analytics:** Interactive Pie Charts breaking down spending habits by category.
* **🔐 Biometric Security:** Integrated `local_auth` for Fingerprint and FaceID protection upon app launch.
* **💾 Local Persistence:** Full offline capability using **SQLite**; no data leaves the device.
* **⚡ State Management:** Efficient state handling using the **Provider** pattern.
* **🎨 Material 3 Design:** Modern, dark-themed UI with reactive components.

## 🛠️ Tech Stack

* **Framework:** Flutter (Dart)
* **Database:** SQLite (`sqflite`)
* **State Management:** Provider
* **Security:** Local Authentication (`local_auth`)
* **Charts:** FL Chart
* **Architecture:** MVVM-inspired (Services, Models, Providers, Screens)

## 📸 Screenshots

| Home | Analytics | Security |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/76983c1c-38ec-4348-9234-abf7c004bfd7" width="200"> | <img src="https://github.com/user-attachments/assets/75f97e76-2129-4fdf-b9a1-64c8f2a9d360" width="200"> | <img src="https://github.com/user-attachments/assets/6f02a40a-5d80-4cd2-8fd4-be746194d721" width="200"> |

## 🔧 Installation & Setup

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/flutter-expense-tracker-local-first.git](https://github.com/YOUR_USERNAME/flutter-expense-tracker-local-first.git)
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run the App**
    *(Note: Requires physical device for Biometrics)*
    ```bash
    flutter run
    ```

## 🧠 Technical Highlights

* **Database Optimization:** Implements a Singleton pattern for the Database Service to ensure a single active connection.
* **Security Protocol:** Modifies the Android `MainActivity` to extend `FlutterFragmentActivity`, enabling secure biometric prompt overlays.
* **Privacy First:** Zero-knowledge architecture; user financial data is stored 100% locally on the device.

## 🔜 Roadmap

* [ ] Monthly Budget Caps & Alerts
* [ ] PDF Export for Statements
* [ ] Cloud Backup Option (Encrypted)

---
**Author:** [Aphiwe Mntambo]
**University:** University of the Western Cape (UWC)
