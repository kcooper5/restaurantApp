//
//  OrderConfirmationViewController.swift
//  restApp
//
//  Created by Robert Marcolina Jr. on 3/7/18.
//  Copyright © 2018 kcooper5. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    var minutes: Int!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    

    @IBAction func goBackToOrder(_ sender: Any) {
        performSegue(withIdentifier: "DismissConfirmation", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "If you got to this stage, I am very shocked. Now you have to wait \(minutes!) minutes for whatever you just ordered."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}