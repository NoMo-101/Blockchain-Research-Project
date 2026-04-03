# Blockchain-Research-Project

📡 SDR Signal Log (Smart Contract)

A lightweight Solidity smart contract for logging Software Defined Radio (SDR) signal readings on-chain.

This contract allows external scripts, oracles, or devices to submit signal data such as frequency, signal strength (RSSI), and detection status in a verifiable and immutable way.

🚀 Overview

The SDRSignalLog contract stores radio signal readings submitted by users (typically automated scripts or hardware systems). Each reading is permanently recorded on the blockchain and can be retrieved later.

This is useful for:

Signal monitoring systems
Research and experimentation with SDR data
Verifiable logging of radio activity
Combining on-chain records with off-chain datasets
📦 Data Structure

Each signal reading includes:

reporter → Address that submitted the reading
freqHz → Frequency in Hz
rssi → Signal strength (range: -150 to 0)
detected → Whether a signal was detected
time → Block timestamp
metaHash → Optional hash of off-chain data (e.g., IQ files, JSON, logs)
⚙️ Functions
submitReading(...)

Submits a new signal reading to the blockchain.

Parameters:

freqHz (uint256): Frequency in Hz (must be > 0 and ≤ 300 GHz)
rssi (int256): Signal strength (must be between -150 and 0)
detected (bool): Signal presence
metaHash (bytes32): Optional hash of off-chain metadata

Returns:

id (uint256): ID of the newly stored reading
totalReadings()

Returns the total number of readings stored.

getReading(id)

Fetches a specific reading by ID.

Requirements:

ID must exist (bounds checked)
🔒 Input Validation

The contract enforces:

Frequency must be within realistic SDR bounds (0 < freq ≤ 300 GHz)
RSSI must be within valid signal strength range (-150 to 0)
📡 Events
ReadingSubmitted

Emitted whenever a new reading is added.

Includes:

Reading ID
Reporter address
Frequency
RSSI
Detection status
Metadata hash
Timestamp
🧠 How It Works
A script or SDR system detects a signal
It calls submitReading() with the data
The contract validates and stores the reading
The reading is permanently recorded and can be retrieved anytime
🔗 Off-Chain Data (metaHash)

The metaHash field allows you to link additional data stored off-chain, such as:

IQ recordings
Detailed signal analysis
JSON metadata
Files stored on IPFS or other storage systems
🛠️ Example Use Case
An SDR device scans frequencies continuously
When a signal is detected, it logs:
Frequency
Signal strength
Detection status
Extra data is saved off-chain and hashed
The hash is stored on-chain for verification
📄 License

MIT License

✨ Future Improvements (Optional Ideas)
Add filtering/search functions
Support batching multiple readings
Integrate with Chainlink oracles
Add access control (if needed)
Frontend dashboard for visualization
