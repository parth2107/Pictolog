//
//  ViewController.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-13.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var btnGettingStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    
    // to navigate from InitialVC to HomeVC
    @IBAction func btnGettingStartedTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

