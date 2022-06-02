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

func greetingLogic() -> String {
  let hour = Calendar.current.component(.hour, from: Date())
  
  let NEW_DAY = 0
  let NOON = 12
  let SUNSET = 18
  let MIDNIGHT = 24
  
  var greetingText = "Hello, Harman" // Default greeting text
  switch hour {
  case NEW_DAY..<NOON:
      greetingText = "Good Morning, Harman"
  case NOON..<SUNSET:
      greetingText = "Good Afternoon, Harman"
  case SUNSET..<MIDNIGHT:
      greetingText = "Good Evening, Harman"
  default:
      _ = "Hello, Harman"
  }
  
  return greetingText
}
