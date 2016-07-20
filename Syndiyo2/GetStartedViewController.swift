//
//  GetStartedViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        continueButton.layer.cornerRadius = 15
    }
    
    @IBAction func continueButtonPressed(sender: AnyObject) {
        let viewController = MedicalInformationViewController(nibName: "MedicalInformationViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
