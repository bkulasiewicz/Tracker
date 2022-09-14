//
//  MapViewController.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 08/09/2022.
//

import UIKit
import MapKit
import RxSwift

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    enum Constans {
        static var regionRadius: CLLocationDistance = 50000
    }
    
    let disposeBag = DisposeBag()
    var presented: PresentableGPX?
    
    let mapViewModel: MapFeeder
    
    init?(mapViewModel: MapFeeder,
          coder: NSCoder) {
        self.mapViewModel = mapViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupBindings()
    }

    func setupBindings() {
        mapViewModel.presentableGPX
            .map { [weak self] presentableGPX -> PresentableGPX in
                self?.removeArifacts()
                return presentableGPX
            }
            .map({ [weak self] presentableGPX -> PresentableGPX in
                self?.store(presentableGPX)
                return presentableGPX
            })
            .line(in: mapView.addOverlay)
            .start(in: mapView.addAnnotation)
            .end(in: mapView.addAnnotation)
            .map({$0.line.coordinate})
            .subscribe(with: self, onNext: { owner, lineCenter in
                let region = MKCoordinateRegion(center: lineCenter,
                                                latitudinalMeters: Constans.regionRadius,
                                                longitudinalMeters: Constans.regionRadius)
                
                owner.mapView.setRegion(region, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: Helpers
extension MapViewController {
    private func removeArifacts() {
        if let displayedEnd = presented?.end {
            mapView.removeAnnotation(displayedEnd)
        }
        if let displayedLine = presented?.line {
            mapView.removeOverlay(displayedLine)
        }
        if let displayedStart = presented?.start {
            mapView.removeAnnotation(displayedStart)
        }
    }
    
    private func store(_ presentableGPX: PresentableGPX) {
        presented = presentableGPX
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.75)
            renderer.lineWidth = 7
            return renderer
        }

        return MKOverlayRenderer()
    }
}


