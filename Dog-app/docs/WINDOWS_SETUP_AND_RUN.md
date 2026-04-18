# Windows Setup + Run Guide (PowerShell + Notepad)

## 1) Run bootstrap script

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
cd <repo-path>
.\Dog-app\setup\windows\setup-dog-app.ps1
```

This script:
- Creates `E:\Dog app`.
- Installs Git, Node.js LTS, Flutter, and Notepad++ using `winget`.
- Creates quick-launch folders for all apps.

## 2) Open folders in Notepad++

You can open any project folder directly, such as:
- `Dog-app\main-website`
- `Dog-app\admin-webapp`
- `Dog-app\customer-app`
- `Dog-app\ngo-app`
- `Dog-app\admin-app`

## 3) Run web apps

```powershell
cd Dog-app\main-website
npm install
npm run dev
```

```powershell
cd Dog-app\admin-webapp
npm install
npm run dev
```

## 4) Run Flutter apps

```powershell
cd Dog-app\customer-app
flutter pub get
flutter run
```

```powershell
cd Dog-app\ngo-app
flutter pub get
flutter run
```

```powershell
cd Dog-app\admin-app
flutter pub get
flutter run
```

## 5) Suggested next steps

- Add backend APIs for incident creation and NGO assignment.
- Add Firebase push notifications.
- Add map integration and route ETA.
- Add auth (OTP + NGO verification).
