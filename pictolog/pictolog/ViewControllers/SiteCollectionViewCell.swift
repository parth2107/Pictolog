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
    @IBOutlet weak var lblSiteVisitedOn: UILabel!
    
    func createCustomCell(place: NSManagedObject){
        viewSiteCell.layer.cornerRadius = 10
        let date = place.value(forKeyPath: "visited_on") as! NSDate
        lblSiteName.text! = place.value(forKeyPath: "name") as! String
        lblSiteVisitedOn.text! = convertDateString(date: date)
    }
}
