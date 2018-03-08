//
//  MenuItemDetailViewController.swift
//  restApp
//
//  Created by cyber on 3/7/18.
//  Copyright © 2018 kcooper5. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var menuItem: MenuItem!
    var delegate: AddToOrderDelegate?
    
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform =
            CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform =
            CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
    
    //My Override
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailViewController = segue.destination
                as! MenuItemDetailViewController
            let index = tableview.indexPathForSelectedRow!.row
            menuItemDetailViewController.menuItem = menuItem[index]
        }
    }
    //My Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()
    }
    
    func setupDelegate() {
        if let navController =
            tabBarController?.viewControllers?.last as?
            UINavigationController,
            let orderTableViewController =
            navController.viewControllers.first as?
            OrderTableViewController {
            delegate = orderTableViewController
        }
    }
    
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        addToOrderButton.layer.cornerRadius = 5.0
        MenuController.shared.fetchImage(url: menuItem.imageURL)
        { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
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
