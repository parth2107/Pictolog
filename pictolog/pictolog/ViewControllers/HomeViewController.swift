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
    var sites: [NSManagedObject] = []
    
    @IBOutlet weak var collectionViewSites: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSites.delegate = self
        collectionViewSites.dataSource = self
        
        imgViewProfilePic.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Site")
        
        do{
            sites =  try _managedContext.fetch(fetchRequest)
            print(sites)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
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
    
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCollectionViewCell", for: indexPath) as! SiteCollectionViewCell
        cell.lblSiteName.text! = sites[indexPath.row].value(forKeyPath: "name") as! String

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize=UIScreen.main.bounds
        return CGSize(width: 170, height: 70)
    }
    
}
