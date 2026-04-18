# Deploy Guide: Vercel + Render

This project currently has **two React web apps** you can deploy immediately:

- `Dog-app/main-website`
- `Dog-app/admin-webapp`

Flutter apps (`customer-app`, `ngo-app`, `admin-app`) are mobile apps and are not deployed to Vercel/Render directly.

---

## 1) Deploy to Vercel (recommended for React frontends)

You should create **two separate Vercel projects** (one per web app).

### Main Website

1. Push code to GitHub.
2. In Vercel dashboard: **Add New → Project**.
3. Import repository.
4. Configure:
   - **Root Directory:** `Dog-app/main-website`
   - **Framework Preset:** `Vite`
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
5. Click **Deploy**.

### Admin Webapp

Repeat with:
- **Root Directory:** `Dog-app/admin-webapp`
- Other settings same as above.

### Vercel CLI (optional)

```bash
npm i -g vercel
cd Dog-app/main-website
vercel
```

Then do the same for `Dog-app/admin-webapp`.

---

## 2) Deploy to Render

Use **Static Site** service for each React app.

### Main Website on Render

1. Push repo to GitHub.
2. In Render: **New + → Static Site**.
3. Connect repo.
4. Configure:
   - **Root Directory:** `Dog-app/main-website`
   - **Build Command:** `npm install && npm run build`
   - **Publish Directory:** `dist`
5. Create Static Site.

### Admin Webapp on Render

Create second Static Site with:
- **Root Directory:** `Dog-app/admin-webapp`
- Same build/publish commands.

---

## 3) SPA routing note (important)

If you later add React Router routes, configure rewrite rules so deep links work.

### Vercel rewrite (`vercel.json`)

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

### Render redirect/rewrite

In Render Static Site settings, add a rule that rewrites all paths to `/index.html`.

---

## 4) Environment variables

If your web apps later call APIs, define environment variables in both platforms:

- Vercel: Project Settings → Environment Variables
- Render: Static Site → Environment

For Vite, variables must start with `VITE_` (example: `VITE_API_BASE_URL`).

---

## 5) What to deploy where

- **Vercel:** best for the React frontends in this repo right now.
- **Render:** also good for React static hosting, and can host future backend APIs in one place.

