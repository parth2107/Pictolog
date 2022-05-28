//
//  PlaceDetailViewController.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-27.
//

import UIKit

class PlaceDetailViewController: UIViewController {

    @IBOutlet weak var lblPlaceVisitedOn: UILabel!
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblPlaceVenue: UILabel!
    @IBOutlet weak var lblPlaceNote: UITextView!
    
    @IBOutlet weak var collectionViewImages: UICollectionView!
    
    var placeDetail:Place?
    var placePhotos:[Data]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionViewImages.dataSource = self
        collectionViewImages.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let placeName = placeDetail?.value(forKeyPath: "name") as? String {
            lblPlaceName.text! = placeName
        }
        
        if let placeDateOfVisit = placeDetail?.value(forKeyPath: "visited_on") as? NSDate {
            lblPlaceVisitedOn.text! = convertDateString(date: placeDateOfVisit)
        }
        
        let placeCity = placeDetail!.value(forKeyPath: "city") as! City
        let placeCityName = placeCity.value(forKeyPath: "name") as! String
        
        let placeProvince = placeDetail!.value(forKeyPath: "province") as! Province
        let placeProvinceName = placeProvince.value(forKeyPath: "name") as! String
        
        let placeCountry = placeDetail!.value(forKeyPath: "country") as! Country
        let placeCountryName = placeCountry.value(forKeyPath: "name") as! String
        
        let photos = placeDetail!.value(forKeyPath: "image") as! Image
        placePhotos = photos.value(forKeyPath: "photo") as! [Data]
        
        lblPlaceVenue.text! = placeCityName + ", " + placeProvinceName + " - " + placeCountryName
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension PlaceDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        placePhotos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceImageCollectionViewCell", for: indexPath) as! PlaceImageCollectionViewCell
        cell.imgViewPlace.image = UIImage(data: placePhotos![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100,height: 100)
    }
}
