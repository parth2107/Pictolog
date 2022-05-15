//
//  HomeViewController.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-13.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var imgViewProfilePic: UIImageView!
    
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
    
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCollectionViewCell", for: indexPath) as! SiteCollectionViewCell
        cell.lblSiteName.text! = sites[indexPath.row].value(forKeyPath: "name") as! String
        return cell
    }
    
}
