import SwiftUI

struct SettingsScrn: View {
    @Binding var navPath: [Scrns]
    
    var body: some View {
        VStack(spacing: 0) {
            
            BackBtn(navPath: $navPath)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
            
            VStack(spacing: 17) {
                MainActnBtn(txt: "Contact Us", actn: {})
                MainActnBtn(txt: "Privacy Policy", actn: {})
                MainActnBtn(txt: "Rate Us", actn: {})
            }.padding(.top, 400)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            VStack(spacing: 0) {
                Image("homeMainImage")
                    .frame(maxWidth: .infinity, maxHeight: 402)
                
                Spacer()
            }.background(Color.background)
        )

    }    
}


#Preview {
    @Previewable @State var navPath: [Scrns] = []
    SettingsScrn(navPath: $navPath)
}


