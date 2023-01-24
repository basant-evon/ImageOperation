//
//  Extension.swift
//  MyImageWork
//
//  Created by Kumar Basant on 24/01/23.
//

import Foundation
import UIKit
extension UIButton{
    func setUI(){
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .blue
        
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
}
extension UIView{
    
    func setCorner(){
       
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
}
/*
extension UIImage {
    
    class func imageByCombiningImage(firstImage: UIImage, withImage secondImage: UIImage) -> UIImage {
        
        let newImageWidth  = max(firstImage.size.width,  secondImage.size.width )
        let newImageHeight = max(firstImage.size.height, secondImage.size.height)
        let newImageSize = CGSize(width : newImageWidth, height: newImageHeight)
        
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        let firstImageDrawX  = round((newImageSize.width  - firstImage.size.width  ) / 2)
        let firstImageDrawY  = round((newImageSize.height - firstImage.size.height ) / 2)
        
        let secondImageDrawX = round((newImageSize.width  - secondImage.size.width ) / 2)
        let secondImageDrawY = round((newImageSize.height - secondImage.size.height) / 2)
        
        firstImage.draw(at: CGPoint(x: firstImageDrawX,  y: firstImageDrawY))
        secondImage.draw(at: CGPoint(x: secondImageDrawX, y: secondImageDrawY))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        
        return image ?? UIImage()
    }
}*/
