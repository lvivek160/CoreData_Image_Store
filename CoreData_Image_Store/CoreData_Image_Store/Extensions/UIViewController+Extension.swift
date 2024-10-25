//
//  UIViewController+Extension.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit

extension UIViewController{
    func showAlert(message: String?){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

extension UIViewController{
    class var id: String { return String(describing: self) }
}


