//
//  UIImageView+Extension.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit

extension UIImageView{
    func getImageToDocumentDirectory(name: String){
        let imageURL = URL.documentsDirectory.appending(components: name).appendingPathExtension("png")
        self.image = UIImage(contentsOfFile: imageURL.path)
    }
    
    func saveImageToDocumentDirectory(imageName: String){
        let fileURL = URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png")
        if let data = self.image?.pngData(){
            do{
                //save data on particular path
                try data.write(to: fileURL)
            }
            catch let error{
                print("image Storing Error:-", error)
            }
            
        }
    }

}
