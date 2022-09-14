//
//  GPXFileReader.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 08/09/2022.
//

import Foundation

protocol GPXReader {
    func read(_ data: Data) -> GPXFileReader.GPXData?
}

class GPXFileReader: NSObject, XMLParserDelegate, GPXReader {
    struct GPXData {
        var coordinates: [Coordinate]
        var speed: [String]
        
        struct Coordinate {
            let latitude: String
            let longitude: String
        }
    }

    var readData = GPXData(coordinates: [], speed: [])

    func read(_ data: Data) -> GPXData? {
        let parser = XMLParser(data: data)
        parser.delegate = self
        let success = parser.parse()
        guard success else { return nil }
    
        return readData
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "extraData" {
            guard let speedInKnots = attributeDict["speedInKnots"] else { return }
            
            readData.speed.append(speedInKnots)
        }
        
        if elementName == "trkpt" {
            guard let latitude = attributeDict["lat"], let longitude = attributeDict["lon"] else { return }
            
            readData.coordinates.append(GPXData.Coordinate(latitude: latitude, longitude: longitude))
        }
    }
}
