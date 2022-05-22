//
//  AddSiteViewController.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-14.
//

import UIKit
import CoreData

class AddSiteViewController: UIViewController {

    @IBOutlet weak var txtFieldSiteName: UITextField!
    @IBOutlet weak var txtFieldCity: UITextField!
    @IBOutlet weak var txtFieldProvince: UITextField!
    @IBOutlet weak var txtFieldCountry: UITextField!
    @IBOutlet weak var txtFieldVisitedOn: UITextField!
    @IBOutlet weak var txtFieldNote: UITextField!
    @IBOutlet weak var txtFieldLatitude: UITextField!
    @IBOutlet weak var txtFieldLongitude: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
      
    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        
        guard let placeName = txtFieldSiteName.text else {
            print("Invalid Place Name")
            return
        }
        
        guard let forCity = txtFieldCity.text else {
            print("Invalid City")
            return
        }
        
        guard let forProvince = txtFieldProvince.text else {
            print("Invalid province")
            return
        }
        
        guard let forCountry = txtFieldCountry.text else {
            print("Invalid Country")
            return
        }
        
        guard let visitedOn = txtFieldVisitedOn.text else {
            print("Invalid Visited On")
            return
        }
        
        guard let note = txtFieldNote.text else {
            print("Invalid Note")
            return
        }
        
        guard let latitude = Double(txtFieldLatitude.text!) else {
            print("Invalid Latitude")
            return
        }
        
        guard let longitude = Double(txtFieldLongitude.text!) else {
            print("Invalid Longitude")
            return
        }
        

        let dateFormatter = ISO8601DateFormatter()
        
        let country = DataManager.shared.createCountry(name: forCountry)
        let province = DataManager.shared.createProvince(name: forProvince, country: country)
        let city = DataManager.shared.createCity(name: forCity, province: province, country: country)
        
        
        let newPlace = DataManager.shared.createPlace(name: placeName, city: city, province: province, country: country, visitedOn: dateFormatter.date(from:visitedOn)!, latitude: latitude, longitude: longitude, note: note)
        
        
//        let entity = NSEntityDescription.entity(forEntityName: "Place", in: _managedContext)!
//        let site = NSManagedObject(entity: entity, insertInto: _managedContext)
//        site.setValue(txtFieldSiteName.text!, forKey: "name")
////        site.setValue(txtFieldCity.text!, forKey: "city")
        
        do {
            try DataManager.shared.saveContext()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    

}
