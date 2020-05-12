//
//  Extensions.swift
//  123
//
//  Created by gdml on 06/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let finish = dateFormatterPrint.string(from: Date())
        return finish
    }
    
}
extension Int {
    
    func convertToCelsius() -> Int {
        return abs(Int(self - 32) * Int(5.0) / Int(9.0))
    }
    
}

extension UIImage {
    
    func imageResize (sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
        func areaAverage() -> UIColor {
            var bitmap = [UInt8](repeating: 0, count: 4)

            if #available(iOS 9.0, *) {
                // Get average color.
                let context = CIContext()
                let inputImage: CIImage = ciImage ?? CoreImage.CIImage(cgImage: cgImage!)
                let extent = inputImage.extent
                let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
              let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
                let outputImage = filter.outputImage!
                let outputExtent = outputImage.extent
                assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)

                // Render to bitmap.
              context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
            } else {
                // Create 1x1 context that interpolates pixels when drawing to it.
                let context = CGContext(data: &bitmap, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
                let inputImage = cgImage ?? CIContext().createCGImage(ciImage!, from: ciImage!.extent)

                // Render to bitmap.
                context.draw(inputImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
            }

            // Compute result.
            let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
            return result
        }
    }



