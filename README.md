# Blockchain-Research-Project
# 📡 SDR Signal Log (Smart Contract)

A lightweight Solidity smart contract for logging Software Defined Radio (SDR) signal readings on-chain.

This contract allows external scripts, oracles, or devices to submit signal data such as frequency, signal strength (RSSI), and detection status in a verifiable and immutable way.

---

## 🚀 Overview

`SDRSignalLog` stores radio signal readings submitted by users (typically automated scripts or SDR hardware systems). Each reading is permanently recorded on-chain and can be retrieved at any time.

### 💡 Use Cases
- SDR signal monitoring systems  
- Blockchain-based research logging  
- Verifiable radio activity tracking  
- Linking on-chain logs with off-chain datasets  

---

## 📦 Data Structure

Each reading contains:

| Field       | Type     | Description |
|------------|----------|-------------|
| reporter   | address  | Address that submitted the reading |
| freqHz     | uint256  | Frequency in Hz |
| rssi       | int256   | Signal strength (-150 to 0) |
| detected   | bool     | Signal detected or not |
| time       | uint256  | Block timestamp |
| metaHash   | bytes32  | Hash of off-chain data |

---

## ⚙️ Functions

### `submitReading(uint256 freqHz, int256 rssi, bool detected, bytes32 metaHash)`

Submits a new SDR reading.

**Requirements:**
- `freqHz` must be > 0 and ≤ 300,000,000,000 (300 GHz)
- `rssi` must be between -150 and 0

**Returns:**
- `uint256 id` → ID of the new reading

---

### `totalReadings()`

Returns the total number of readings stored.

---

### `getReading(uint256 id)`

Retrieves a reading by ID.

**Requirements:**
- `id` must be within range

---

## 🔒 Input Validation

The contract ensures:
- Valid frequency range (SDR realistic bounds)
- Valid RSSI values (signal strength limits)

---

## 📡 Events

### `ReadingSubmitted`

Emitted when a new reading is logged.

Includes:
- `id`
- `reporter`
- `freqHz`
- `rssi`
- `detected`
- `metaHash`
- `time`

---

## 🧠 How It Works

1. SDR system detects a signal  
2. Script/oracle calls `submitReading()`  
3. Contract validates input  
4. Reading is stored on-chain  
5. Event is emitted  

---

## 🔗 Off-Chain Data (metaHash)

The `metaHash` field links to external data such as:
- IQ recordings  
- JSON metadata  
- Signal analysis files  
- IPFS / decentralized storage  

---

## 🛠️ Example Workflow

```text
SDR Device → Script → Smart Contract → Blockchain Storage
                         ↓
                  Off-chain storage (IPFS, etc.)
```

---

## 📁 Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SDRSignalLog {
    struct Reading {
        address reporter;
        uint256 freqHz;
        int256 rssi;
        bool detected;
        uint256 time;
        bytes32 metaHash;
    }

    Reading[] public readings;

    event ReadingSubmitted(
        uint256 indexed id,
        address indexed reporter,
        uint256 freqHz,
        int256 rssi,
        bool detected,
        bytes32 metaHash,
        uint256 time
    );

    function submitReading(
        uint256 freqHz,
        int256 rssi,
        bool detected,
        bytes32 metaHash
    ) external returns (uint256 id) {

        require(freqHz > 0 && freqHz <= 300_000_000_000, "Invalid frequency");
        require(rssi >= -150 && rssi <= 0, "RSSI out of range");

        id = readings.length;
        readings.push(Reading({
            reporter: msg.sender,
            freqHz: freqHz,
            rssi: rssi,
            detected: detected,
            time: block.timestamp,
            metaHash: metaHash
        }));

        emit ReadingSubmitted(id, msg.sender, freqHz, rssi, detected, metaHash, block.timestamp);
    }

    function totalReadings() external view returns (uint256) {
        return readings.length;
    }

    function getReading(uint256 id) external view returns (Reading memory) {
        require(id < readings.length, "ID out of range");
        return readings[id];
    }
}
```

---

## 🚀 Future Improvements

- Filtering/search functionality  
- Batch submission of readings  
- Chainlink oracle integration  
- Access control (role-based submissions)  
- Frontend dashboard (data visualization)  

---

## 📄 License

MIT License
