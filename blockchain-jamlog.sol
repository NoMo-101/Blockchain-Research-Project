// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SDRSignalLog {
    struct Reading {
        address reporter;     // who submitted (your oracle/script wallet)
        uint256 freqHz;       // frequency in Hz
        int256 rssi;          // signal strength (signed, e.g. -42)
        bool detected;        // signal present?
        uint256 time;         // block timestamp
        bytes32 metaHash;     // optional: hash of extra off-chain data (IQ file, JSON, etc.)
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

        //Input Validation
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

    // Returns total number of readings logged — derived live from array length, never out of sync
    function totalReadings() external view returns (uint256) {
        return readings.length;
    }

    // Retrieve a single reading by its ID with bounds checking
    function getReading(uint256 id) external view returns (Reading memory) {
    require(id < readings.length, "ID out of range");
    return readings[id];
    }
}