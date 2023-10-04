//
//  applyPerspectiveTransform.swift
//  PJT_Camera
//
//  Created by 諸田紘一 on 2023-10-04.
//

import CoreImage
import UIKit
import CoreImage.CIFilterBuiltins

// 透視変換を適用する関数
func applyPerspectiveTransform(inputImage: UIImage, topLeft: CGPoint, topRight: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint) -> UIImage? {
    // 入力画像をCIImageに変換
    let inputCIImage = CIImage(image: inputImage)
    
    // CIFilterを初期化し、透視変換フィルターを設定
    guard let perspectiveFilter = CIFilter(name: "CIPerspectiveTransform") else {
        return nil
    }
    
    // 入力画像をフィルターに設定
    perspectiveFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
    
    // xとyの値をそれぞれリストに格納
    let xValues: [CGFloat] = [
        topLeft.x, topRight.x, bottomLeft.x, bottomRight.x
    ]

    let yValues: [CGFloat] = [
        topLeft.y, topRight.y, bottomLeft.y, bottomRight.y
    ]

    // CIVectorを作成
    let perspectiveVector = CIVector(values: xValues + yValues, count: 8)

    // 各頂点に透視変換ベクトルを設定
    perspectiveFilter.setValue(perspectiveVector, forKey: "inputTopLeft")
    perspectiveFilter.setValue(perspectiveVector, forKey: "inputTopRight")
    perspectiveFilter.setValue(perspectiveVector, forKey: "inputBottomLeft")
    perspectiveFilter.setValue(perspectiveVector, forKey: "inputBottomRight")
    
    // 出力CIImageを取得
    if let outputCIImage = perspectiveFilter.outputImage {
        // CIContextを作成してCGImageに変換
        let context = CIContext(options: nil)
        if let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
            // CGImageからUIImageに変換して返す
            return UIImage(cgImage: outputCGImage)
        }
    }
    
    // 変換に失敗した場合はnilを返す
    return nil
}
