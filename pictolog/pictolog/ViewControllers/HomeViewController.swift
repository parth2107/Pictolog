//
//  HomeViewController.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-13.
//

import UIKit
import CoreData
import MapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblGreetingMessage: UILabel!
    @IBOutlet weak var segmentForView: UISegmentedControl!
    @IBOutlet weak var imgViewProfilePic: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnAddSite: UIButton!
    var places: [NSManagedObject] = []
    
    @IBOutlet weak var collectionViewSites: UICollectionView!
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSites.delegate = self
        collectionViewSites.dataSource = self
        mapView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        
        do{
            places =  try _managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
        lblGreetingMessage.text = greetingLogic()
        
        addPlacesAsAnnotationsInMapView(places)
        
        imgViewProfilePic.layer.cornerRadius = 10
        mapView.layer.cornerRadius = 10
        btnAddSite.layer.cornerRadius = 10
        
        collectionViewSites.reloadData()
        
    }
    
    // MARK: - Actions

    @IBAction func btnAddSiteTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddSiteViewController") as! AddSiteViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // function for segment
    @IBAction func segmantBtnTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.isHidden=false
            collectionViewSites.isHidden=true
        case 1 :
            mapView.isHidden=true
            collectionViewSites.isHidden=false
        default:
            print("do nothing for now")
            
        }
    }
    
    // MARK: - Other Funcation
    
    func addPlacesAsAnnotationsInMapView(_ places: [NSManagedObject]) {
        
        for place in places {
            
            let placeName = (place.value(forKeyPath: "name") as! String)
            let placeLatitude = (place.value(forKeyPath: "latitude") as! Double)
            let placeLongitude = (place.value(forKeyPath: "longitude") as! Double)
            var placeVisitedOn:String = ""
            
            if let placeDateOfVisit = place.value(forKeyPath: "visited_on") as? NSDate {
                placeVisitedOn = convertDateString(date: placeDateOfVisit)
            }
            
            // Show artwork on map
            let artwork = Artwork(
              title: placeName,
              locationName: placeVisitedOn,
              discipline: "Place",
              coordinate: CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude))
            
            mapView.addAnnotation(artwork)
            print("placeLatitude: \(placeLatitude) and placeLongitude: \(placeLongitude)")
        }
    }
    
    func navigateToPlaceDetailScreen(withPlaceDetail:Place) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaceDetailViewController") as! PlaceDetailViewController
        vc.placeDetail = withPlaceDetail
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchPlaceFromLatAndLong(latitude: Double, longitude: Double) -> Place! {
        
        for place in places {
            let lat = (place.value(forKeyPath: "latitude") as! Double)
            let long = (place.value(forKeyPath: "longitude") as! Double)
            
            if(lat.isEqual(to: latitude) && long.isEqual(to: longitude)) {
                return place as? Place
            }
        }
        return nil
    }
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCollectionViewCell", for: indexPath) as! SiteCollectionViewCell
        cell.createCustomCell(place: places[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170,height: 100)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPlaceDetailScreen(withPlaceDetail: places[indexPath.row] as! Place)
    }
    
}

// MARK: - MapView Delegate Methods

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Artwork else {
          return nil
        }
        
        let identifier = "artwork"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          
          view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
      }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let artwork = view.annotation as? Artwork else {
            return
        }
        
        let selectedPlace = fetchPlaceFromLatAndLong(latitude: artwork.coordinate.latitude, longitude: artwork.coordinate.longitude)
        navigateToPlaceDetailScreen(withPlaceDetail: selectedPlace!)
    }
}
