//
//  TimeSeriesIntradayDataType.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import Foundation

struct TimeSeriesIntradayDataType: Decodable {
    var something: String?//[Intraday]?
    
    enum CodingKeys: String, CodingKey {
        case something
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        something = try container.decode([Intraday].self, forKey: CodingKeys.something)
        
//        let container = try decoder.container(keyedBy: CodingKeys.something)
        something = container.codingPath.first?.stringValue
        
//        var data = try container.decode(DecodedArray<TimeSeriesDateTime>.self, forKey: CodingKeys.data)
        // Decode firstName & lastName
//        data = try container.decode(TimeSeriesDateTime.self, forKey: CodingKeys.data)
//            lastName = try container.decode(String.self, forKey: CodingKeys.lastName)

        // Extract studentId from coding path
//        data = try container.decode(DecodedArray<[TimeSeriesDateTime]>.self, forKey: (container.codingPath as? TimeSeriesIntradayDataType.CodingKeys)!)
        
    }
}

struct Intraday: Codable {
    var some: [IntradayData]?
    
    enum CodingKeys: String, CodingKey {
        case some
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        data = .decode([IntradayData].self, from: CodingKeys.self)
        
        some = try container.decode([IntradayData].self, forKey: CodingKeys.some)
        
        
    }
}

struct IntradayData: Codable {
    var open: String?
    var high: String?
    var low: String?
    
    enum CodingKeys: String, CodingKey {
        case open
        case high
        case low
    }
}

struct TimeSeriesDateTime: Codable {
    var dateTime: String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = container.codingPath.first!.stringValue
    }
}

struct DecodedArray<T: Decodable>: Decodable {

    typealias DecodedArrayType = [T]

    private var array: DecodedArrayType

    // Define DynamicCodingKeys type needed for creating decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {

        // Create decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = DecodedArrayType()

        // Loop through each keys in container
        for key in container.allKeys {

            // Decode T using key & keep decoded T object in tempArray
            let decodedObject = try container.decode(T.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        // Finish decoding all T objects. Thus assign tempArray to array.
        array = tempArray
    }
}

extension DecodedArray: Collection {

    // Required nested types, that tell Swift what our collection contains
    typealias Index = DecodedArrayType.Index
    typealias Element = DecodedArrayType.Element

    // The upper and lower bounds of the collection, used in iterations
    var startIndex: Index { return array.startIndex }
    var endIndex: Index { return array.endIndex }

    // Required subscript, based on a dictionary index
    subscript(index: Index) -> Iterator.Element {
        get { return array[index] }
    }

    // Method that returns the next index when iterating
    func index(after i: Index) -> Index {
        return array.index(after: i)
    }
}




