//
//  ViewModel.swift
//  Swift-ArKit
//
//  Created by 강치우 on 1/10/24.
//

import Foundation
import UIKit
import PencilKit

class ViewModel: ObservableObject {
    @Published var drawing: UIImage?
    @Published var canvasView = PKCanvasView()
    @Published var isShowingView = false
}

// PKCanvasView를 UIImage로 변환하는 기능 추가
extension PKCanvasView {
    func asImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        
        let image = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}
