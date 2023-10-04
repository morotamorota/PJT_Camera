//
//  PerspectiveTransformView.swift
//  PJT_Camera
//
//  Created by 諸田紘一 on 2023-10-04.
//

import SwiftUI

struct PerspectiveTransformView: View {
    @State private var image: UIImage?
    @State private var topLeft: CGPoint = CGPoint(x: 50, y: 50)
    @State private var topRight: CGPoint = CGPoint(x: 250, y: 50)
    @State private var bottomLeft: CGPoint = CGPoint(x: 50, y: 350)
    @State private var bottomRight: CGPoint = CGPoint(x: 250, y: 350)
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .border(Color.gray, width: 1)
                    .gesture(DragGesture().onChanged({ value in
                        // ドラッグジェスチャーによって座標を更新
                        // ここでtopLeft、topRight、bottomLeft、bottomRightを更新します
                    }))
            }
            
            Button("Apply Perspective Transform") {
                if let inputImage = UIImage(named: "your_input_image") {
                    if let transformedImage = applyPerspectiveTransform(
                        inputImage: inputImage,
                        topLeft: topLeft,
                        topRight: topRight,
                        bottomLeft: bottomLeft,
                        bottomRight: bottomRight
                    ) {
                        image = transformedImage
                    }
                }
            }
        }
    }
}
