//
//  DrawView.swift
//  Swift-ArKit
//
//  Created by 강치우 on 1/10/24.
//

import SwiftUI
import PencilKit

struct DrawView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var selectedColor: Color = .black
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 드로잉 캔버스 표시
                DrawingView(canvasView: $viewModel.canvasView, selectedColor: $selectedColor)
                
                // 추가 컨트롤 및 버튼
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        // 그리기 색상을 선택하는 컬러피커
                        ColorPicker("Color", selection: $selectedColor)
                            .labelsHidden()
                        
                        Button("Clear") {
                            viewModel.canvasView.drawing = PKDrawing()
                        }
                        
                        Button("Done") {
                            convertPencilkitViewToTimage()
                            viewModel.isShowingView = false
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.canvasView.drawing = PKDrawing()
        }
    }
    
    // PencilKit 뷰를 변환하는 함수
    func convertPencilkitViewToTimage() {
        if let image = viewModel.canvasView.asImage() {
            viewModel.drawing = image
        }
    }
}

struct DrawingView: UIViewRepresentable {
    
    @Binding var canvasView: PKCanvasView
    @Binding var selectedColor: Color
    
    // PKCanvasView 생성 및 초기 구성 설정
    func makeUIView(context: Context) -> some PKCanvasView {
        // 캔버스에서 모든 입력을 허용
        canvasView.drawingPolicy = .anyInput
        // 초기 그리기 도구를 검정색, 두께 5.0 펜으로 설정
        canvasView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: .black, width: 5.0)
        return canvasView
    }
    
    // 선택한 색상으로 그리기 도구 업데이트
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: UIColor(selectedColor), width: 5.0)
    }
}
