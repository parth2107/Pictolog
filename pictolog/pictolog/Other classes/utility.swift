//
//  utility.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-15.
//

import Foundation
import UIKit

class pictologButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 10
//        self.backgroundColor = UIColor(red: 243, green: 151, blue: 102, alpha: 1)
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.white.cgColor
    }
    
}
