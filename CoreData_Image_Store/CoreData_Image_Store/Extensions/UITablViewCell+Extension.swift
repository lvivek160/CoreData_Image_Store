//
//  UITablViewCell+Configuration.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit

extension UITableViewCell{
   class var id: String { return String(describing: self) }
   class var nib: UINib { return UINib(nibName: self.id, bundle: nil) }
}
