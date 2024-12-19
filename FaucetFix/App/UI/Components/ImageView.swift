import SwiftUI

struct ImageView: View {
    let imageData: UIImageData?
    
    var body: some View {
        VStack {
            if let uiImage = imageData?.toUIImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
    }
}
