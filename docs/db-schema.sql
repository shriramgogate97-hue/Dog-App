-- Core schema for multivendor ecommerce + logistics orchestration

CREATE TABLE users (
  id UUID PRIMARY KEY,
  role TEXT NOT NULL CHECK (role IN ('ADMIN','SELLER','CUSTOMER','RIDER','HUB_MANAGER','EXECUTIVE')),
  full_name TEXT NOT NULL,
  email TEXT UNIQUE,
  phone TEXT UNIQUE,
  password_hash TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE sellers (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id),
  legal_name TEXT NOT NULL,
  brand_name TEXT,
  gstin TEXT,
  fssai_number TEXT,
  udyam_number TEXT,
  kyc_status TEXT NOT NULL DEFAULT 'PENDING',
  commission_percent NUMERIC(5,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE products (
  id UUID PRIMARY KEY,
  seller_id UUID NOT NULL REFERENCES sellers(id),
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  category TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  is_seasonal BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE product_variants (
  id UUID PRIMARY KEY,
  product_id UUID NOT NULL REFERENCES products(id),
  sku TEXT NOT NULL UNIQUE,
  weight_grams INTEGER,
  size_label TEXT,
  mrp NUMERIC(10,2) NOT NULL,
  selling_price NUMERIC(10,2) NOT NULL,
  stock_qty INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
  id UUID PRIMARY KEY,
  order_number TEXT NOT NULL UNIQUE,
  customer_id UUID NOT NULL REFERENCES users(id),
  status TEXT NOT NULL,
  payment_mode TEXT NOT NULL CHECK (payment_mode IN ('COD','ONLINE','WALLET')),
  payment_status TEXT NOT NULL,
  subtotal NUMERIC(10,2) NOT NULL,
  shipping_charge NUMERIC(10,2) NOT NULL DEFAULT 0,
  gst_total NUMERIC(10,2) NOT NULL DEFAULT 0,
  discount_total NUMERIC(10,2) NOT NULL DEFAULT 0,
  grand_total NUMERIC(10,2) NOT NULL,
  delivery_pincode TEXT NOT NULL,
  estimated_delivery_date DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE order_items (
  id UUID PRIMARY KEY,
  order_id UUID NOT NULL REFERENCES orders(id),
  seller_id UUID NOT NULL REFERENCES sellers(id),
  variant_id UUID NOT NULL REFERENCES product_variants(id),
  qty INTEGER NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL,
  line_total NUMERIC(10,2) NOT NULL
);

CREATE TABLE shipments (
  id UUID PRIMARY KEY,
  order_id UUID NOT NULL REFERENCES orders(id),
  shipment_type TEXT NOT NULL CHECK (shipment_type IN ('FORWARD','RETURN','RTO','EXCHANGE')),
  provider_code TEXT NOT NULL,
  awb_number TEXT,
  tracking_id TEXT,
  current_status TEXT NOT NULL,
  is_hyperlocal BOOLEAN NOT NULL DEFAULT FALSE,
  otp_code TEXT,
  otp_attempt_count INTEGER NOT NULL DEFAULT 0,
  origin_hub_id UUID,
  destination_hub_id UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE tracking_events (
  id BIGSERIAL PRIMARY KEY,
  shipment_id UUID NOT NULL REFERENCES shipments(id),
  event_code TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  actor_type TEXT,
  city TEXT,
  state TEXT,
  country TEXT,
  event_time TIMESTAMPTZ NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb
);

CREATE INDEX idx_tracking_events_shipment_time ON tracking_events(shipment_id, event_time DESC);

CREATE TABLE return_requests (
  id UUID PRIMARY KEY,
  order_item_id UUID NOT NULL REFERENCES order_items(id),
  request_type TEXT NOT NULL CHECK (request_type IN ('RETURN','EXCHANGE')),
  reason TEXT,
  status TEXT NOT NULL,
  approved_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE hubs (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  code TEXT NOT NULL UNIQUE,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  pincode TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE rider_runsheets (
  id UUID PRIMARY KEY,
  rider_id UUID NOT NULL REFERENCES users(id),
  hub_id UUID NOT NULL REFERENCES hubs(id),
  run_date DATE NOT NULL,
  status TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE rider_runsheet_items (
  id UUID PRIMARY KEY,
  runsheet_id UUID NOT NULL REFERENCES rider_runsheets(id),
  shipment_id UUID NOT NULL REFERENCES shipments(id),
  stop_sequence INTEGER NOT NULL,
  task_status TEXT NOT NULL DEFAULT 'ASSIGNED'
);
