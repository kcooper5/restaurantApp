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
    
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = menuItems.reduce(0.0) { (result, menuItem)
            -> Double in return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Submit",
            style: .default) { action in
            self.uploadOrder()
            })
            alert.addAction(UIAlertAction(title: "Cancel",
            style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    
    func uploadOrder() {
        let menuIds = menuItems.map { $0.id }
        MenuController.shared.submitOrder(menuIds: menuIds)
        { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier:
                        "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination
                as! OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
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
