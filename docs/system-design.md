# Gogate Products — Multivendor Ecommerce + Logistics Platform (Blueprint)

## 1) Platform Goals

Build a unified system with these channels:

- **Customer web app** (`mystore.gogateproducts.store`)
- **Admin control panel** (`admin.gogateproducts.store`)
- **Seller panel** (`seller.gogateproducts.store`)
- **Logistics control panel** (`logistics.gogateproducts.store`)
- **Hub panel** (`hubs.gogateproducts.store`)
- **Delivery agent PWA / Android wrapper**

Primary business features:

- Multivendor catalog + commission
- Marketplace checkout + COD + online payments
- Courier orchestration (third-party + internal first/middle/last mile)
- Hyperlocal live tracking only
- Rich tracking timeline with timestamps
- OTP delivery workflow with retry + RTO automation
- Returns / exchange / reverse pickup lifecycle
- GST invoice automation + pincode serviceability + ETA estimation

## 2) Recommended Stack

### Frontend

- Next.js 14+ (App Router, SSR, SEO)
- Tailwind CSS + shadcn/ui
- Zustand / TanStack Query
- PWA support for agent app (installable web app)

### Backend

- NestJS (modular + enterprise workflow)
- PostgreSQL (orders, inventory, GST)
- Redis (rate cache, timelines, websocket pub/sub)
- WebSockets (tracking + rider status)
- BullMQ (async jobs: label generation, retries, webhook handling)

### Infra

- Docker + Docker Compose (dev)
- Nginx/Caddy reverse proxy (subdomain routing)
- S3-compatible object storage (labels, invoices, POD media)
- Cloudflare CDN + WAF

## 3) Service Boundaries

1. **Identity & Access Service**
   - RBAC: Admin, Seller, Customer, Hub Manager, Rider, Executive
   - KYC/FSSAI/GST document verification states
2. **Catalog Service**
   - Product, variant, seasonal inventory, price rules
3. **Marketplace Service**
   - Cart, checkout, coupon, order placement, refunds, wallet
4. **Logistics Orchestrator Service**
   - Rate fetch, courier selection, AWB/label, shipment events
5. **Internal Logistics Service**
   - Hub scan flow, runsheet, assignment, OTP, attempt management
6. **Tracking Service**
   - Canonical timeline builder for customer-facing tracking
7. **Finance & GST Service**
   - Invoices, GST reports, settlement, vendor payouts
8. **Returns Service**
   - Return/exchange workflows + reverse pickup orchestration
9. **Notification Service**
   - Email/SMS/WhatsApp/push for OTP and status updates

## 4) Canonical Order Lifecycle

```text
PLACED -> CONFIRMED -> PACKED -> READY_FOR_PICKUP ->
SHIPPED -> IN_TRANSIT -> OUT_FOR_DELIVERY -> DELIVERED

Exceptional: CANCELLED, RTO_INITIATED, RTO_IN_TRANSIT, RTO_DELIVERED
Returns: RETURN_REQUESTED -> RETURN_APPROVED -> RETURN_PICKED -> RETURN_QC -> RETURN_COMPLETED
```

## 5) Tracking Timeline Model (Amazon-like)

Each timeline event contains:

- `event_code`
- `title`
- `description`
- `event_time`
- `actor_type` (seller/courier/hub/rider/system)
- `location_city/state/country`
- `metadata` (awb, OTP required, attempt count, etc.)

This supports rendering customer strings like:

- "Your order has been placed"
- "Seller has processed your order"
- "Shipment yet to be picked up"
- "Your item has arrived/left facility"
- "Out for delivery"
- "Delivered"

## 6) Delivery OTP + Attempts Logic

- OTP generated when shipment enters `OUT_FOR_DELIVERY`
- OTP visible to customer panel and rider app
- Up to **3 delivery attempts** allowed
- If all attempts fail: auto mark `RTO_INITIATED` and create reverse shipment
- Rider can request OTP resend from app

## 7) Hyperlocal Tracking

- Only Gogate internal hyperlocal shipments publish live coordinates
- Coordinates emitted by rider device every N seconds
- Customer sees rider marker + ETA from Google Maps Distance Matrix API
- Non-hyperlocal / 3rd party shipments show event-based tracking only

## 8) Pincode Serviceability + ETA

ETA decision inputs:

- source hub
- destination pincode
- courier SLA table
- dispatch cutoff windows
- product lead time (seasonal stock)

Display on PDP: "Estimated delivery by <date>" after pincode check.

## 9) Payments

Adapter strategy pattern for:

- Razorpay
- Paytm
- Easebuzz
- Cashfree

Features:

- online prepaid
- COD
- COD-to-online conversion link
- wallet credits/refunds

## 10) Courier Integrations

Unified adapter layer for:

- Shiprocket
- Pidge
- Shadowfax
- Borzo
- Mover
- iThink Logistics
- Shipway
- Shipmozo
- optional Delhivery / BlueDart

Adapter contract:

- `getRates()`
- `createShipment()`
- `generateLabel()`
- `schedulePickup()`
- `track()`
- `cancelShipment()`
- `createReverseShipment()`

## 11) Admin Features

- seller onboarding + KYC approval
- executive/hub creation and role mapping
- commission setup (global/category/seller)
- refund approval queue
- courier rule engine
- serviceability matrix management
- GST reports + payout settlements
- NDR/RTO command center

## 12) Seller Features

- product CRUD + variants
- bulk CSV import/export
- inventory by season/batch
- shipping preference and pickup address
- order processing states
- return authorization view
- payout/wallet ledger

## 13) Hub + Rider Features

Hub panel:

- inbound/outbound bag creation
- barcode scan (shipment label)
- manifest, sorting, dispatch closing

Rider app:

- runsheet and stop sequence
- task start/end
- shipment barcode scan before action
- OTP verification at delivery/pickup
- failed attempt reason capture
- COD collection proof

## 14) Security & Compliance

- JWT + refresh token rotation
- device/session management
- signed URL for document access
- audit log for admin/seller actions
- webhooks with HMAC verification
- PII encryption at rest for sensitive fields

## 15) Delivery Plan

1. Foundation: auth, roles, catalog, order core
2. Seller onboarding + product/variant flows
3. Payment adapters + invoicing
4. Logistics orchestrator + tracking timeline
5. Hub/rider app flows + OTP + attempts
6. Returns/RTO automation
7. Observability, perf, security hardening
