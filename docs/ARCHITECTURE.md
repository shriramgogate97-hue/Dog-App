# Technical Architecture Blueprint

## Recommended Stack (Implemented Direction)
- **Frontend**: Next.js + Tailwind + TypeScript
- **Backend**: NestJS microservices
- **DB**: PostgreSQL (transactional), Redis (cache/pub-sub), Meilisearch (search)
- **Messaging**: Redis Streams/Kafka-ready abstraction
- **Realtime**: WebSockets (tracking and timeline updates)
- **Storage**: S3-compatible object store for images/docs/labels
- **Infra**: Docker + Cloudflare + AWS/DigitalOcean

## Bounded Contexts (Services)
1. Identity & Access Service
2. Catalog Service
3. Seller Service
4. Order Service
5. Payment Service
6. Logistics Orchestrator Service
7. Shipment Tracking Service
8. Returns Service
9. Wallet & Ledger Service
10. Notification Service (Email/SMS/WhatsApp)
11. Analytics Service

## Order State Machine
`PLACED -> CONFIRMED -> PROCESSING -> PACKED -> READY_TO_SHIP -> SHIPPED -> OUT_FOR_DELIVERY -> DELIVERED`

Return path:
`RETURN_REQUESTED -> RETURN_APPROVED -> RETURN_PICKUP_SCHEDULED -> RETURN_PICKED -> RETURN_QC -> REFUND_INITIATED -> REFUNDED`

Failure path:
`ATTEMPT_1_FAILED -> ATTEMPT_2_FAILED -> ATTEMPT_3_FAILED -> RTO_INITIATED -> RTO_IN_TRANSIT -> RTO_RECEIVED`

## Logistics Event Model (Key Events)
- `shipment.created`
- `pickup.scheduled`
- `pickup.out_for_pickup`
- `pickup.completed`
- `hub.inscan`
- `hub.outscan`
- `shipment.in_transit`
- `shipment.out_for_delivery`
- `shipment.delivery_otp_generated`
- `shipment.delivery_attempt_failed`
- `shipment.delivered`
- `shipment.rto_initiated`
- `return.created`
- `return.pickup_completed`

## Courier Adapter Strategy
Each provider gets a dedicated adapter implementing common interface:
- Rate quote
- Serviceability
- Create shipment
- Generate label
- Schedule pickup
- Cancel shipment
- Track shipment
- Create reverse pickup

Initial adapters:
- Shiprocket
- Pidge
- Shadowfax
- Borzo
- iThink Logistics
- Shipway
- Shipmozo
- Delhivery (optional)
- BlueDart (optional)
- Internal Gogate Logistics

## Security & Compliance
- JWT + refresh tokens + device binding for agent app
- AES encryption for sensitive docs
- Document vault for GST/FSSAI/KYC
- Immutable audit logs
- OTP replay prevention
- Role-based permission matrix

## Multi-App UI Surfaces
- Customer Web: products, wallet, tracking, returns
- Seller Web: listings, KYC, orders, shipment booking
- Admin Web: full governance, rates, commissions, disputes
- Logistics Web: control tower, route/hub/line-haul, courier switching
- Hub Web: in-scan/out-scan, bagging, route handover
- Agent App: runsheet, scan, OTP, proof capture, COD actions

