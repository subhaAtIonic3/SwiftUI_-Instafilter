//
//  ContentView.swift
//  Instafilter
//
//  Created by Subhrajyoti Chakraborty on 24/08/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    func loadImage() {
        guard let inputImage = UIImage(named: "example") else { return }
        let beginImage = CIImage(image: inputImage)
        let context  = CIContext()
        
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        //        let currentFilter = CIFilter.pixellate()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.scale = 100
        
        //  Causing error in SwiftUI
        //        let currentFilter = CIFilter.crystallize()
        //        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //        currentFilter.radius = 200
        
        //        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        //        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        //        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
        
    }
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .onAppear(perform: loadImage)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
