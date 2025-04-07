//import SwiftUI
//import UniformTypeIdentifiers
//
//struct ContentView: View {
//    
//    @State private var position = CGPoint(x: 200, y: 700)
//    
//    var body: some View {
//            ZStack{
//                animationSequence().offset(x: 0, y: 10.0)
//                .position(x: self.position.x, y: self.position.y)
//                .gesture(
//                    DragGesture()
//                        .onChanged { value in
//                            self.position.x = value.location.x
//                            self.position.y = value.location.y}
//                )
//                
//            
//        }
//       
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
////create array for images
//
//var images : [UIImage]! = [
//    UIImage(named: "happy1")!,
//    UIImage(named: "happy2")!,
//    UIImage(named: "happy3")!,
//    UIImage(named: "happy2")!,
//    UIImage(named: "happy1")!,
//]
//
////var images : [UIImage]! = [
////    UIImage(named: "normal1")!,
////    UIImage(named: "normal2")!,
////]
//
////var images : [UIImage]! = [
////    UIImage(named: "sad1")!,
////    UIImage(named: "sad2")!,
////    UIImage(named: "sad3")!,
////    UIImage(named: "sad2")!,
////    UIImage(named: "sad1")!,
////]
//
//let animatedImages = UIImage.animatedImage(with: images, duration: 1)
//
//struct animationSequence: UIViewRepresentable {
//    
//    func makeUIView(context: Context) -> UIView {
//        let seqAnimView = UIViewType(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//        let seqImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//        seqImage.clipsToBounds = true
//        seqImage.layer.cornerRadius = 20
//        seqImage.autoresizesSubviews = true
//        seqImage.contentMode = UIView.ContentMode.scaleAspectFill
//        seqImage.image = animatedImages
//        seqAnimView.addSubview(seqImage)
//        return seqAnimView
//        
//    }
//    
//    
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<animationSequence>) {
//        
//    }
//}

import SwiftUI

// MARK: - Image Animation Setup
let images: [UIImage] = [
    UIImage(named: "sad1")!,
    UIImage(named: "sad2")!,
    UIImage(named: "sad3")!,
    UIImage(named: "sad2")!,
    UIImage(named: "sad1")!
]

let animatedImages = UIImage.animatedImage(with: images, duration: 1)


// MARK: - UIViewRepresentable Wrapper
struct animationSequence: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        let imageView = UIImageView(frame: container.bounds)
        imageView.image = animatedImages
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        container.addSubview(imageView)
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No need to update anything for now
    }
}

