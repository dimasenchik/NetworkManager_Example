//
//  Alertable.swift
//  EvoZhuk
//
//  Created by Dima Senchik on 7/9/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import Foundation
import UIKit

protocol Alertable {
    func displayError(_ error: String)
    
    func displayMessage(_ title: String, message: String?, actions: UIAlertAction?..., handler: ((UIAlertAction) -> ())?)
    
    func displaySheet(_ title: String?, message: String?, actions: [UIAlertAction], cancelActionHandler: ((UIAlertAction) -> ())?)
}

extension Alertable where Self: UIViewController {
    
    func displayError(_ error: String) {
        displayMessage("Error", message: error, actions: nil, handler: nil)
    }
    
    func displayMessage(_ title: String, message: String?, actions: UIAlertAction?..., handler: ((UIAlertAction) -> ())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions == [nil] {
            let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
            alertController.addAction(dismissAction)
        } else {
            actions.forEach { action in
                guard let act = action else { return }
                
                alertController.addAction(act)
            }
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func displaySheet(_ title: String?, message: String?, actions: [UIAlertAction], cancelActionHandler: ((UIAlertAction) -> ())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelActionHandler)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actions.forEach({ alertController.addAction($0) })
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
