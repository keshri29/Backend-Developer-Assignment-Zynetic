-- Create tables for historical data
CREATE TABLE IF NOT EXISTS meter_readings (
    id SERIAL PRIMARY KEY,
    meter_id VARCHAR(255) NOT NULL,
    kwh_consumed_ac DECIMAL(12, 4) NOT NULL,
    voltage DECIMAL(8, 2),
    timestamp TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS vehicle_readings (
    id SERIAL PRIMARY KEY,
    vehicle_id VARCHAR(255) NOT NULL,
    soc DECIMAL(5, 2) CHECK (soc >= 0 AND soc <= 100),
    kwh_delivered_dc DECIMAL(12, 4),
    battery_temp DECIMAL(5, 2),
    timestamp TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create operational table (Hot Storage)
CREATE TABLE IF NOT EXISTS live_status (
    vehicle_id VARCHAR(255) PRIMARY KEY,
    soc DECIMAL(5, 2) CHECK (soc >= 0 AND soc <= 100),
    kwh_delivered_dc DECIMAL(12, 4),
    battery_temp DECIMAL(5, 2),
    meter_id VARCHAR(255),
    kwh_consumed_ac DECIMAL(12, 4),
    voltage DECIMAL(8, 2),
    last_updated TIMESTAMP DEFAULT NOW()
);

-- Create mapping table
CREATE TABLE IF NOT EXISTS vehicle_meter_mapping (
    vehicle_id VARCHAR(255) PRIMARY KEY,
    meter_id VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_meter_timestamp ON meter_readings(meter_id, timestamp);
CREATE INDEX IF NOT EXISTS idx_vehicle_timestamp ON vehicle_readings(vehicle_id, timestamp);
CREATE INDEX IF NOT EXISTS idx_timestamp ON vehicle_readings(timestamp);
CREATE INDEX IF NOT EXISTS idx_live_vehicle ON live_status(vehicle_id);
