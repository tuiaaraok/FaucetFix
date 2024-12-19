import SwiftUI

struct MainActnBtn: View {
    let txt: String
    let actn: () -> Void
    
    var body: some View {
        Button(action: actn) {
            ZStack {
                Rectangle()
                    .fill(Color.mainAdd)
                    
                    .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                Text(txt)
                    .padding(12)
                    .customFont(.mainActnBtnTxt)
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 52)
            
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
    }
}

#Preview {
    MainActnBtn(txt: "Some Text", actn: {})
}

