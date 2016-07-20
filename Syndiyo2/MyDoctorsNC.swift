//
//  MyDoctorsNC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/21/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class MyDoctorsNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.greenColor()
        
        
        // Do any additional setup after loading the view.
        
        let addDoctorsVC = MyDoctorsViewController(nibName: "MyDoctorsViewController", bundle: nil)

        let addDoctorsPage = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
        self.pushViewController(addDoctorsVC, animated: false)
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
