//
//  CharacteristicUVIndex.swift
//  BluetoothMessageProtocol
//
//  Created by Kevin Hoogheem on 8/26/17.
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

/// BLE UV Index Characteristic
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CharacteristicUVIndex: Characteristic {

    /// Characteristic Name
    public static var name: String {
        return "UV Index"
    }

    /// Characteristic UUID
    public static var uuidString: String {
        return "2A76"
    }

    /// UV Index
    private(set) public var uvIndex: UInt8

    /// Creates UV Index Characteristic
    ///
    /// - Parameter uvIndex: UV Index
    public init(uvIndex: UInt8) {
        self.uvIndex = uvIndex

        super.init(name: CharacteristicUVIndex.name,
                   uuidString: CharacteristicUVIndex.uuidString)
    }

    /// Deocdes the BLE Data
    ///
    /// - Parameter data: Data from sensor
    /// - Returns: Characteristic Instance
    /// - Throws: BluetoothMessageProtocolError
    open override class func decode(data: Data) throws -> CharacteristicUVIndex {
        var decoder = DataDecoder(data)

        let value = decoder.decodeUInt8()

        return CharacteristicUVIndex(uvIndex: value)
    }

    /// Encodes the Characteristic into Data
    ///
    /// - Returns: Data representation of the Characteristic
    /// - Throws: BluetoothMessageProtocolError
    open override func encode() throws -> Data {
        var msgData = Data()

        msgData.append(uvIndex)

        return msgData
    }
}
