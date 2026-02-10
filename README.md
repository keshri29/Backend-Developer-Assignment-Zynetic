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
