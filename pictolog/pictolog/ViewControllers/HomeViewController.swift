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
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        
        do{
            places =  try _managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
        addPlacesAsAnnotationsInMapView(places)
        
        imgViewProfilePic.layer.cornerRadius = 10
        mapView.layer.cornerRadius = 10
        btnAddSite.layer.cornerRadius = 10
        
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
            
            // Show artwork on map
            let artwork = Artwork(
              title: placeName,
              locationName: placeName,
              discipline: "Place",
              coordinate: CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude))
            
            mapView.addAnnotation(artwork)
            print("placeLatitude: \(placeLatitude) and placeLongitude: \(placeLongitude)")
        }
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
   
    
}
