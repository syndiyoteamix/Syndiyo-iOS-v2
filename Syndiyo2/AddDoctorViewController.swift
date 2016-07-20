//
//  AddDoctorViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class AddDoctorViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        cardView.layer.shadowColor = UIColor.blueColor().CGColor
//        cardView.layer.shadowOpacity = 1
//        cardView.layer.shadowOffset = CGSizeZero
//        cardView.layer.shadowRadius = 10
//        cardView.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
