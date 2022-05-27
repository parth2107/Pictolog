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
    
    var placeDetail:Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        lblPlaceVenue.text! = placeCityName + ", " + placeProvinceName + " - " + placeCountryName
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}