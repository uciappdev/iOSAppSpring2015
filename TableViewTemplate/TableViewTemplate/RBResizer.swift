//
//  RBResizer.swift
//  TableViewTemplate
//
//  Created by Jake on 6/3/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

//import Foundation

import UIKit

func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage? {
    return RBResizeImage(RBSquareImage(image), size)
}

func RBSquareImage(image: UIImage) -> UIImage? {
    var originalWidth  = image.size.width
    var originalHeight = image.size.height
    
    var edge: CGFloat
    if originalWidth > originalHeight {
        edge = originalHeight
    } else {
        edge = originalWidth
    }
    
    var posX = (originalWidth  - edge) / 2.0
    var posY = (originalHeight - edge) / 2.0
    
    var cropSquare = CGRectMake(posX, posY, edge, edge)
    
    var imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
    return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
}

func RBResizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
    if let image = image {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    } else {
        return nil
    }
}

func RBShrinkToFit(image: UIImage?, targetSize: CGSize) -> UIImage? {
    // If the image is bigger than the view, scale it to fit inside the view. - Jake
    if let image = image {
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize : CGSize = size
        if widthRatio > heightRatio {
            if size.height > targetSize.height {
                newSize.height = targetSize.height
                newSize.width *= heightRatio
            }
        }
        else {
            if size.width > targetSize.width {
                newSize.width = targetSize.width
                newSize.height = widthRatio * newSize.height
            }
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage

    }
    else {
        return nil
    }
}










