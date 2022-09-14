//
//  MainCoordinator.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 09/09/2022.
//

import Foundation
import UIKit

class MainCoordinator {
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private let sharedMapViewModel = MapViewModel()
    
    private var mainTabBarVC: UITabBarController {
        let vc = UITabBarController()
        vc.viewControllers = [mapVC, filesVC]
        
        return vc
    }
    
    private var mapVC: MapViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") {  coder in
            MapViewController(mapViewModel: self.sharedMapViewModel, coder: coder)
        }

        return vc
    }
    
    private var filesVC: FilesViewController {
        let filesDataSource = FilesDataSource(fileNames: ["Late running", "Party", "Return from the party"])
        let gpxReader = GPXFileReader()
        let filesViewModel = FilesViewModel(filesDataSource: filesDataSource,
                                            gpxReader: gpxReader,
                                            mapCommander: self.sharedMapViewModel)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FilesViewController") { coder in
            FilesViewController(filesViewModel: filesViewModel, coder: coder)
        }

        return vc
    }
    
    func showMainDashboard() {
        navigationController.pushViewController(mainTabBarVC, animated: true)
    }
}
