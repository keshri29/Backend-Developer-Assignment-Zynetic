# Energy Ingestion Engine

## Overview
A high-scale ingestion system for processing telemetry data from Smart Meters and EV Fleets.

## Features
- Ingest meter and vehicle telemetry every 60 seconds
- Historical data storage (cold storage)
- Real-time status updates (hot storage)
- Analytics endpoints for performance metrics
- Redis caching for fast access
- PostgreSQL with optimized indexing

## Quick Start

### 1. Start Services
```bash
docker-compose up -d --build
2. Initialize Database
bash
docker-compose exec postgres psql -U admin -d energy_db -f /docker-entrypoint-initdb.d/001-initial-schema.sql
3. Start Application
bash
npm install
npm run start:dev
API Endpoints
Ingestion
POST /v1/ingest/meter - Ingest meter telemetry

POST /v1/ingest/vehicle - Ingest vehicle telemetry

Analytics
GET /v1/analytics/performance/:vehicleId - Get 24-hour performance summary

GET /v1/analytics/status/:vehicleId - Get current vehicle status

Architecture
Hot Storage: live_status table for real-time data (UPSERT)

Cold Storage: meter_readings and vehicle_readings for historical data (INSERT only)

Cache Layer: Redis for frequently accessed data

Database: PostgreSQL with daily partitioning (for scale)

Handling Scale
Daily Volume: 14.4 million records (10,000 devices × 2 streams × 60/min × 24h)

Optimizations: Indexing, partitioning, connection pooling, batch processing

text

---

## ✅ **PART 10: FINAL STEPS**

### **Step 30: Build for production**
```bash
npm run build
Step 31: Run the complete system
bash
# All in one command
docker-compose down
docker-compose up -d --build
Step 32: Verify everything is running
bash
# Check if containers are running
docker ps

# Check application logs
docker-compose logs app

# Test with curl
curl http://localhost:3000/v1/analytics/status/ev_001

