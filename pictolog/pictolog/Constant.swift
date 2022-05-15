//
//  Constant.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-14.
//

import Foundation
import UIKit

let _appDelegator = { return UIApplication.shared.delegate! as! AppDelegate }()

let _managedContext = { return _appDelegator.persistentContainer.viewContext}()
