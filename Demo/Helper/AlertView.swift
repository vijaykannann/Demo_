//
//  AlertView.swift
//  Demo
//
//  Created by VJ's iMAC on 25/08/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{

public static func showAlert(title: String, description: String, controller: UIViewController){
    let alertController = UIAlertController(title: title , message: description, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    alertController.addAction(dismissAction)
    controller.present(alertController, animated: true, completion: nil)
}
}
