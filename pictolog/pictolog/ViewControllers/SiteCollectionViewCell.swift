//
//  SiteCollectionViewCell.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-14.
//

import UIKit
import CoreData

class SiteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewSiteCell: UIView!
    @IBOutlet weak var lblSiteName: UILabel!
    
    func createCustomCell(place: NSManagedObject){
        viewSiteCell.layer.cornerRadius = 10
        lblSiteName.text! = place.value(forKeyPath: "name") as! String
    }
}
