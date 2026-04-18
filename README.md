# Gogate Products WebApp

This repository now contains a multi-app starter kit for a **Dog Rescue & Animal Incident Network** concept.

## What is included

- `Dog-app/main-website` – ReactJS public website for reporting incidents and awareness.
- `Dog-app/admin-webapp` – ReactJS admin dashboard for analytics and operations.
- `Dog-app/customer-app` – Flutter mobile app for citizens/reporters.
- `Dog-app/ngo-app` – Flutter mobile app for NGO rescue teams.
- `Dog-app/admin-app` – Flutter mobile app for field admins.
- `Dog-app/setup/windows/setup-dog-app.ps1` – PowerShell + winget setup script for Windows (E drive folder creation + tool installation).
- `Dog-app/docs/` – product planning and execution notes.

## Quick start (Windows PowerShell)

Run in **PowerShell as Administrator**:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
cd <path-to-this-repo>
.\Dog-app\setup\windows\setup-dog-app.ps1
```

Then follow `Dog-app/docs/WINDOWS_SETUP_AND_RUN.md`.
