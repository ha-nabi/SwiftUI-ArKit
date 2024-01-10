//
//  ContentView.swift
//  Swift-ArKit
//
//  Created by 강치우 on 1/10/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)

        // Create a cube model
        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .red, roughness: 0.15, isMetallic: true)
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.transform.translation.y = 0.25

        // Create a sphere model
        let sphere_mesh = MeshResource.generateSphere(radius: 0.1)
        let sphere_material = SimpleMaterial(color: .blue, isMetallic: true)
        let sphere_model = ModelEntity(mesh: sphere_mesh, materials: [sphere_material])
        sphere_model.transform.translation.y = 0.1
        
        // Creat a plane model
        let plane_mesh = MeshResource.generatePlane(width: 0.2, depth: 0.3, cornerRadius: 0.05)
        let plane_material = SimpleMaterial(color: .white, isMetallic: false)
        let plane_model = ModelEntity(mesh: plane_mesh, materials: [plane_material])

        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(model)
        anchor.children.append(sphere_model)
        anchor.children.append(plane_model)
        

        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)

        return arView

    }

    func updateUIView(_ uiView: ARView, context: Context) {}

}
