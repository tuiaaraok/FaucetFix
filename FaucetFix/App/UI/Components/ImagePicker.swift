import SwiftUI

struct ImagePickerView: View {
    @Binding var imageData: UIImageData?
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            Group {
                if let uiImage = imageData?.toUIImage() {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.artframe.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.black)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 135)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
            )
            .onTapGesture {
                isImagePickerPresented = true
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker { selectedImage in
                    imageData = UIImageData(from: selectedImage)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
    }
}

private struct ImagePicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.onImagePicked(uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
