# Phase 01 Implementation Guide (PowerShell + Notepad Workflow)

> You requested PowerShell + Notepad style steps. Below are exact command-driven steps that can be followed in Windows environment.

## 1) Create project folders (PowerShell)
```powershell
mkdir "E:\GOGATE PRODUCTS WEBSITE"
cd "E:\GOGATE PRODUCTS WEBSITE"
mkdir apps, services, packages, infra, docs
```

## 2) Initialize git and workspace
```powershell
git init
ni README.md
ni .gitignore
```

## 3) Create web apps
```powershell
mkdir apps\customer-web, apps\seller-web, apps\admin-web, apps\logistics-web, apps\hub-web, apps\agent-app
```

## 4) Backend services
```powershell
mkdir services\api-gateway, services\order-service, services\logistics-service, services\payment-service, services\tracking-service, services\returns-service
```

## 5) Local infra via Docker
Add `infra/docker-compose.yml` and run:
```powershell
docker compose -f infra\docker-compose.yml up -d
```

## 6) Mandatory first schemas
- users, roles, permissions
- sellers, seller_documents
- products, product_variants, inventory_batches
- carts, orders, order_items
- shipments, shipment_events
- returns, return_events
- wallets, wallet_transactions
- invoices, gst_lines

## 7) MVP APIs to build first
- Auth: login/register/refresh/logout
- Seller onboarding: KYC upload, GST, FSSAI
- Product CRUD with variants
- Checkout + order placement
- Shipment create + track
- Delivery OTP generate/verify
- Return create + reverse pickup request

## 8) Tracking UI timeline (customer)
Display milestones with timestamps:
- Ordered
- Confirmed
- Packed
- Shipped
- Out for Delivery
- Delivered
- Returns

## 9) Delivery attempt rules
- Max 3 attempts
- Failed attempt captures reason and proof
- Auto-RTO initiation after final failure

## 10) Internal logistics rules
- Hub in-scan/out-scan mandatory
- Bag code linked to shipment IDs
- Route = First mile -> Mid mile -> Last mile
- Final delivery confirmation after hub reconciliation

## 11) COD flow
- Agent can collect via QR/payment link
- Real-time status sync to customer/seller/admin
- End-of-day COD reconciliation report

## 12) Production rollout sequence
1. Customer + seller core ecommerce
2. Admin governance panel
3. Internal logistics workflows
4. External courier adapters
5. Advanced AI modules

