//
//  Constant.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-14.
//

import Foundation
import UIKit

let _managedContext = { return DataManager.shared.persistentContainer.viewContext}()

// MARK: - Common Methods
func convertDateString(date: NSDate) -> String {
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM dd,yyyy"

    return dateFormatterPrint.string(from: date as Date)
}
