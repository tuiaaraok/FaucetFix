import SwiftUI

@available(iOS 16.0, *)
struct SettingsScrn: View {
    @Binding var navPath: [Scrns]
    private let storage = Storage.shared
    var body: some View {
        VStack(spacing: 0) {
            
            BackBtn(navPath: $navPath)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
            
            VStack(spacing: 17) {
                MainActnBtn(txt: "Contact Us", actn: { sendEmail(storage.email) })
                MainActnBtn(txt: "Privacy Policy", actn: { openPrivacy(storage.privacyPolicyUrl) })
                MainActnBtn(txt: "Rate Us", actn: { openRate(storage.appId) })
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
    func openRate(_ appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openPrivacy(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func sendEmail(_ email: String) {
        if let url = URL(string: "mailto:\(email)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


