//
//  CharacteristicCrossTrainerData.swift
//  BluetoothMessageProtocol
//
//  Created by Kevin Hoogheem on 8/27/17.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import DataDecoder
import FitnessUnits

/// BLE Cross Trainer Data Characteristic
///
/// The Cross Trainer Data characteristic is used to send training-related data to the Client from a cross trainer (Server).
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicCrossTrainerData: Characteristic {

    /// Characteristic Name
    public static var name: String {
        return "Cross Trainer Data"
    }

    /// Characteristic UUID
    public static var uuidString: String {
        return "2ACE"
    }

    /// Flags
    private struct Flags: OptionSet {
        //Defined as a 24bit by bluetooth
        public let rawValue: UInt32
        public init(rawValue: UInt32) { self.rawValue = rawValue }

        /// More Data not present (is defined opposite of the norm)
        public static let moreData: Flags                       = Flags(rawValue: 1 << 0)
        /// Average Speed present
        public static let avgSpeedPresent: Flags                = Flags(rawValue: 1 << 1)
        /// Total Distance Present
        public static let totalDistancePresent: Flags           = Flags(rawValue: 1 << 2)
        /// Step Count present
        public static let stepCountPresent: Flags               = Flags(rawValue: 1 << 3)
        /// Stride Count present
        public static let strideCountPresent: Flags             = Flags(rawValue: 1 << 4)
        /// Elevation Gain present
        public static let elevationGainPresent: Flags           = Flags(rawValue: 1 << 5)
        /// Inclination and Ramp Angle Setting present
        public static let angleSettingpresent: Flags            = Flags(rawValue: 1 << 6)
        /// Resistance Level Present
        public static let resistanceLevelPresent: Flags         = Flags(rawValue: 1 << 7)
        /// Instantaneous Power present
        public static let instantPowerPresent: Flags            = Flags(rawValue: 1 << 8)
        /// Average Power present
        public static let averagePowerPresent: Flags            = Flags(rawValue: 1 << 9)
        /// Expended Energy present
        public static let expendedEnergyPresent: Flags          = Flags(rawValue: 1 << 10)
        /// Heart Rate present
        public static let heartRatePresent: Flags               = Flags(rawValue: 1 << 11)
        /// Metabolic Equivalent present
        public static let metabolicEquivalentPresent: Flags     = Flags(rawValue: 1 << 12)
        /// Elapsed Time present
        public static let elapsedTimePresent: Flags             = Flags(rawValue: 1 << 13)
        /// Remaining Time present
        public static let remainingTimePresent: Flags           = Flags(rawValue: 1 << 14)
        /// Movement Direction Backwards
        public static let backwardDirection: Flags              = Flags(rawValue: 1 << 15)
    }

    /// Instantaneous Speed
    private(set) public var instantaneousSpeed: FitnessMachineSpeedType?

    /// Average Speed
    private(set) public var averageSpeed: FitnessMachineSpeedType?

    /// Total Distance
    private(set) public var totalDistance: Measurement<UnitLength>?

    /// Step Per Minute
    private(set) public var stepsPerMinute: Measurement<UnitCadence>?

    /// Average Step Rate
    private(set) public var averageStepRate: Measurement<UnitCadence>?

    /// Stride Count
    private(set) public var strideCount: Double?

    /// Positive Elevation Gain
    private(set) public var positiveElevationGain: Measurement<UnitLength>?

    /// Negative Elevation Gain
    private(set) public var negativeElevationGain: Measurement<UnitLength>?

    /// Inclination
    private(set) public var inclination: Measurement<UnitPercent>?

    /// Ramp Angle Setting
    private(set) public var rampAngle: Measurement<UnitAngle>?

    /// Resistance Level
    private(set) public var resistanceLevel: Double?

    /// Instantaneous Power
    private(set) public var instantaneousPower: FitnessMachinePowerType?

    /// Average Power
    private(set) public var averagePower: FitnessMachinePowerType?

    /// Energy Information
    private(set) public var energy: FitnessMachineEnergy

    /// Heart Rate
    private(set) public var heartRate: Measurement<UnitCadence>?

    /// Metabolic Equivalent
    private(set) public var metabolicEquivalent: Double?

    /// Time Information
    private(set) public var time: FitnessMachineTime

    /// Movement Direction
    private(set) public var movementDirection: FitnessMachineMovementDirection

    /// Creates Cross Trainer Data Characteristic
    ///
    /// - Parameters:
    ///   - instantaneousSpeed: Instantaneous Speed
    ///   - averageSpeed: Average Speed
    ///   - totalDistance: Total Distance
    ///   - stepsPerMinute: Step Per Minute
    ///   - averageStepRate: Average Step Rate
    ///   - strideCount: Stride Count
    ///   - positiveElevationGain: Positive Elevation Gain
    ///   - negativeElevationGain: Negative Elevation Gain
    ///   - inclination: Inclination
    ///   - rampAngle: Ramp Angle Setting
    ///   - resistanceLevel: Resistance Level
    ///   - instantaneousPower: Instantaneous Power
    ///   - averagePower: Average Power
    ///   - energy: Energy Information
    ///   - heartRate: Heart Rate
    ///   - metabolicEquivalent: Metabolic Equivalent
    ///   - time: Time Information
    ///   - movementDirection: Movement Direction
    public init(instantaneousSpeed: FitnessMachineSpeedType?,
                averageSpeed: FitnessMachineSpeedType?,
                totalDistance: Measurement<UnitLength>?,
                stepsPerMinute: Measurement<UnitCadence>?,
                averageStepRate: Measurement<UnitCadence>?,
                strideCount: Double?,
                positiveElevationGain: Measurement<UnitLength>?,
                negativeElevationGain: Measurement<UnitLength>?,
                inclination: Measurement<UnitPercent>?,
                rampAngle: Measurement<UnitAngle>?,
                resistanceLevel: Double?,
                instantaneousPower: FitnessMachinePowerType?,
                averagePower: FitnessMachinePowerType?,
                energy: FitnessMachineEnergy,
                heartRate: UInt8?,
                metabolicEquivalent: Double?,
                time: FitnessMachineTime,
                movementDirection: FitnessMachineMovementDirection)
    {
        self.instantaneousSpeed = instantaneousSpeed
        self.averageSpeed = averageSpeed
        self.totalDistance = totalDistance
        self.stepsPerMinute = stepsPerMinute
        self.averageStepRate = averageStepRate
        self.strideCount = strideCount
        self.positiveElevationGain = positiveElevationGain
        self.inclination = inclination
        self.rampAngle = rampAngle
        self.resistanceLevel = resistanceLevel
        self.instantaneousPower = instantaneousPower
        self.averagePower = averagePower
        self.energy = energy

        if let hRate = heartRate {
            self.heartRate = Measurement(value: Double(hRate), unit: UnitCadence.beatsPerMinute)
        } else {
            self.heartRate = nil
        }

        self.metabolicEquivalent = metabolicEquivalent
        self.time = time
        self.movementDirection = movementDirection

        super.init(name: CharacteristicCrossTrainerData.name,
                   uuidString: CharacteristicCrossTrainerData.uuidString)
    }

    /// Deocdes the BLE Data
    ///
    /// - Parameter data: Data from sensor
    /// - Returns: Characteristic Instance
    /// - Throws: BluetoothMessageProtocolError
    open override class func decode(data: Data) throws -> CharacteristicCrossTrainerData {
        var decoder = DataDecoder(data)

        let flags = Flags(rawValue: UInt32(decoder.decodeUInt24()))

        var iSpeed: FitnessMachineSpeedType?
        var avgSpeed: FitnessMachineSpeedType?
        var totalDistance: Measurement<UnitLength>?
        var stepsPerMinute: Measurement<UnitCadence>?
        var averageStepRate: Measurement<UnitCadence>?
        var strideCount: Double?
        var pElevaionGain: Measurement<UnitLength>?
        var nElevaionGain: Measurement<UnitLength>?
        var inclination: Measurement<UnitPercent>?
        var rampAngle: Measurement<UnitAngle>?
        var resistanceLevel: Double?
        var iPower: FitnessMachinePowerType?
        var aPower: FitnessMachinePowerType?
        var heartRate: UInt8?
        var mets: Double?
        var elapsedTime: Measurement<UnitDuration>?
        var remainingTime: Measurement<UnitDuration>?

        /// Available only when More data is NOT present
        if flags.contains(.moreData) == false {
            iSpeed = FitnessMachineSpeedType.create(decoder.decodeUInt16())
        }

        if flags.contains(.avgSpeedPresent) {
            avgSpeed = FitnessMachineSpeedType.create(decoder.decodeUInt16())
        }

        if flags.contains(.totalDistancePresent) {
            let value = Double(decoder.decodeUInt16())
            totalDistance = Measurement(value: value, unit: UnitLength.meters)
        }

        if flags.contains(.stepCountPresent) {
            let steps = decoder.decodeUInt16()
            let stepRate = decoder.decodeUInt16()

            if steps != UInt16.max {
                let spmValue = Double(steps)
                stepsPerMinute = Measurement(value: spmValue, unit: UnitCadence.stepsPerMinute)
            }

            if stepRate != UInt16.max {
                let avgValue = Double(stepRate)
                averageStepRate = Measurement(value: avgValue, unit: UnitCadence.stepsPerMinute)
            }
        }

        if flags.contains(.strideCountPresent) {
            strideCount = decoder.decodeUInt16().resolution(0.1)
        }

        if flags.contains(.elevationGainPresent) {
            let pValue = Double(decoder.decodeUInt16())
            pElevaionGain = Measurement(value: pValue, unit: UnitLength.meters)

            let nValue = Double(decoder.decodeUInt16())
            nElevaionGain = Measurement(value: nValue, unit: UnitLength.meters)
        }

        if flags.contains(.angleSettingpresent) {
            let incline = decoder.decodeInt16()
            let ramp = decoder.decodeInt16()

            if incline != Int16.max {
                let iValue = incline.resolution(0.1)
                inclination = Measurement(value: iValue, unit: UnitPercent.percent)
            }

            if ramp != Int16.max {
                let rValue = ramp.resolution(0.1)
                rampAngle = Measurement(value: rValue, unit: UnitAngle.degrees)
            }
        }

        if flags.contains(.resistanceLevelPresent) {
            resistanceLevel = decoder.decodeInt16().resolution(0.1)
        }

        if flags.contains(.instantPowerPresent) {
            iPower = FitnessMachinePowerType.create(decoder.decodeInt16())
        }

        if flags.contains(.averagePowerPresent) {
            aPower = FitnessMachinePowerType.create(decoder.decodeInt16())
        }

        var fitEnergy: FitnessMachineEnergy
        if flags.contains(.expendedEnergyPresent) {
            fitEnergy = try FitnessMachineEnergy.decode(decoder: &decoder)
        } else {
            fitEnergy = FitnessMachineEnergy(total: nil, perHour: nil, perMinute: nil)
        }

        if flags.contains(.heartRatePresent) {
            heartRate = decoder.decodeUInt8()
        }

        if flags.contains(.metabolicEquivalentPresent) {
            mets = decoder.decodeUInt8().resolution(0.1)
        }

        if flags.contains(.elapsedTimePresent) {
            let value = Double(decoder.decodeUInt16())
            elapsedTime = Measurement(value: value, unit: UnitDuration.seconds)
        }

        if flags.contains(.remainingTimePresent) {
            let value = Double(decoder.decodeUInt16())
            remainingTime = Measurement(value: value, unit: UnitDuration.seconds)
        }

        var movementDirection: FitnessMachineMovementDirection = .forward
        if flags.contains(.backwardDirection) {
            movementDirection = .backward
        }

        let time = FitnessMachineTime(elapsed: elapsedTime, remaining: remainingTime)

        return CharacteristicCrossTrainerData(instantaneousSpeed: iSpeed,
                                              averageSpeed: avgSpeed,
                                              totalDistance: totalDistance,
                                              stepsPerMinute: stepsPerMinute,
                                              averageStepRate: averageStepRate,
                                              strideCount: strideCount,
                                              positiveElevationGain: pElevaionGain,
                                              negativeElevationGain: nElevaionGain,
                                              inclination: inclination,
                                              rampAngle: rampAngle,
                                              resistanceLevel: resistanceLevel,
                                              instantaneousPower: iPower,
                                              averagePower: aPower,
                                              energy: fitEnergy,
                                              heartRate: heartRate,
                                              metabolicEquivalent: mets,
                                              time: time,
                                              movementDirection: movementDirection)
    }

    /// Encodes the Characteristic into Data
    ///
    /// - Returns: Data representation of the Characteristic
    /// - Throws: BluetoothMessageProtocolError
    open override func encode() throws -> Data {
        //Not Yet Supported
        throw BluetoothMessageProtocolError.init(.unsupported)
    }
}
