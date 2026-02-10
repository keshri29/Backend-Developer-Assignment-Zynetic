const axios = require('axios');

const API_URL = 'http://localhost:3000/v1';

async function testAPI() {
  console.log('Testing Energy Ingestion API...\n');

  // Test 1: Ingest meter data
  console.log('1. Testing meter ingestion...');
  try {
    const meterData = {
      meterId: 'meter_001',
      kwhConsumedAc: 15.5,
      voltage: 240,
      timestamp: new Date().toISOString(),
    };
    
    const response = await axios.post(`${API_URL}/ingest/meter`, meterData);
    console.log('✅ Meter ingestion successful:', response.data);
  } catch (error) {
    console.log('❌ Meter ingestion failed:', error.message);
  }

  // Test 2: Ingest vehicle data
  console.log('\n2. Testing vehicle ingestion...');
  try {
    const vehicleData = {
      vehicleId: 'ev_001',
      soc: 85.5,
      kwhDeliveredDc: 12.8,
      batteryTemp: 28.5,
      timestamp: new Date().toISOString(),
    };
    
    const response = await axios.post(`${API_URL}/ingest/vehicle`, vehicleData);
    console.log('✅ Vehicle ingestion successful:', response.data);
  } catch (error) {
    console.log('❌ Vehicle ingestion failed:', error.message);
  }

  // Test 3: Get analytics
  console.log('\n3. Testing analytics endpoint...');
  try {
    const response = await axios.get(`${API_URL}/analytics/performance/ev_001`);
    console.log('✅ Analytics successful:', JSON.stringify(response.data, null, 2));
  } catch (error) {
    console.log('❌ Analytics failed:', error.message);
  }

  // Test 4: Get vehicle status
  console.log('\n4. Testing vehicle status...');
  try {
    const response = await axios.get(`${API_URL}/analytics/status/ev_001`);
    console.log('✅ Vehicle status:', JSON.stringify(response.data, null, 2));
  } catch (error) {
    console.log('❌ Status check failed:', error.message);
  }

  console.log('\n🎉 All tests completed!');
}

testAPI().catch(console.error);