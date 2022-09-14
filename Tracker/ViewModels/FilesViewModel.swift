//
//  FilesViewModel.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 08/09/2022.
//

import Foundation
import CoreLocation

protocol FilesFeeder {
    func loadData() -> Result<[FileCellViewModel], Error>
    
    func select(at index: Int)
}

class FilesViewModel: FilesFeeder {
    private var loadedFiles = [GPXFile]()
    
    struct GPXFile {
        let fileName: String
        let content: GPXFileContent
        
        struct GPXFileContent {
            let averageSpeed: Double
            let coordinates: [CLLocationCoordinate2D]
        }
    }

    let filesDataSource: FilesDataSourceFeeder
    let gpxReader: GPXReader
    let mapCommander: MapCommander
    
    init(filesDataSource: FilesDataSourceFeeder,
         gpxReader: GPXReader,
         mapCommander: MapCommander) {
        self.filesDataSource = filesDataSource
        self.gpxReader = gpxReader
        self.mapCommander = mapCommander
    }
    
    func loadData() -> Result<[FileCellViewModel], Error> {
        let readFiles = getGPXFiles()
        
        loadedFiles = readFiles
    
        return .success(readFiles.cellViewModel())
    }
    
    func select(at index: Int) {
        let selectedFile = loadedFiles[index]
        
        mapCommander.display(for: selectedFile.content.coordinates)
    }
}

extension FilesViewModel {
    private func getGPXFiles() -> [GPXFile] {
        let filesData = filesDataSource
            .getFiles()
        
        let fileNames = filesData.map({$0.fileName})
        
        return filesData
            .map({$0.data})
            .compactMap(gpxReader.read)
            .enumerated()
            .map({GPXFile(fileName: fileNames[$0], content: $1.getFileContent())})
    }
}

extension GPXFileReader.GPXData {
    func getFileContent() -> FilesViewModel.GPXFile.GPXFileContent {
        let sum = speed
            .compactMap({Double($0)})
            .map(Converter.knots2kph)
            .reduce(0, +)
        
        let averageSpeed = sum / Double(speed.count)

        let coordinates = coordinates
            .compactMap({ coordinate -> (lati: CLLocationDegrees, long: CLLocationDegrees)? in
                guard let long = CLLocationDegrees(coordinate.longitude),
                      let lati = CLLocationDegrees(coordinate.latitude) else { return nil }
                
                return (lati, long)
            })
            .compactMap({CLLocationCoordinate2D(latitude: $0.lati, longitude: $0.long)})
        
        return FilesViewModel.GPXFile.GPXFileContent(averageSpeed: averageSpeed, coordinates: coordinates)
    }
}




