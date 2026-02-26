# Gogate Products WebApp

This repository now contains the **implementation blueprint** for a scalable multivendor ecommerce + logistics platform tailored for Gogate Products.

## What is included

- End-to-end architecture covering customer, seller, admin, hub, logistics, and rider experiences.
- Canonical order/tracking lifecycle with timestamps and event model.
- Courier orchestration design for third-party and internal delivery management.
- Database schema starter for ecommerce, shipments, returns, hubs, and runsheets.
- OpenAPI starter contract for core order/logistics/admin flows.

## Documents

- `docs/system-design.md` — platform architecture, features, workflows, and rollout phases.
- `docs/db-schema.sql` — PostgreSQL base schema for core modules.
- `docs/api-spec.yaml` — REST API contract starter.

## Next implementation step

Start coding the services in this order:

1. Auth + RBAC + tenant-aware seller onboarding
2. Catalog + variant inventory + pincode ETA service
3. Checkout + payment adapters + GST invoice module
4. Shipment orchestration + tracking event ingestion
5. Hub/rider workflows + OTP + attempt/RTO automation
6. Returns/exchange + reverse pickup automation
