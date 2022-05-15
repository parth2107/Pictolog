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
    @IBOutlet weak var btnAdd: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
      

    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Site", in: _managedContext)!
        let site = NSManagedObject(entity: entity, insertInto: _managedContext)
        site.setValue(txtFieldSiteName.text!, forKey: "name")
        site.setValue(txtFieldCity.text!, forKey: "city")
        
        do {
            try _managedContext.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    

}
