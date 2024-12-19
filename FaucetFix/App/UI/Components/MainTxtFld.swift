import SwiftUI

struct MainTxtFld: View {
    var ttl: String
    @Binding var txt: String
    var plhldr: String = ""
    var axis: Axis = .horizontal
    var keyboardType: UIKeyboardType = .default
    var maxHeigth: CGFloat = 45
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(ttl)
                .customFont(.infTxt)
                .foregroundColor(Color.black)
            TextField(text: $txt, axis: axis) {
                Text(plhldr)
                    .customFont(.infTxt)
                    .foregroundColor(Color.black)
                    .keyboardType(keyboardType)
            }
            .foregroundColor(Color.black)
            .customFont(.infTxt)
            .padding(12)
            .frame(maxHeight: maxHeigth)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
            )
        }
        .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
    }
}

#Preview {
    @Previewable @State var text: String = ""
    MainTxtFld(ttl: "Title", txt: $text, plhldr: "Placeholder", axis: .horizontal)
}
