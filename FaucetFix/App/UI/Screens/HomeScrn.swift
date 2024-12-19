import SwiftUI

@available(iOS 16.0, *)
struct HomeScrn: View {
    @Binding var navPath: [Scrns]
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack(spacing: 17) {
                MainActnBtn(txt: "Order management", actn: toOrderManagementScrn)
                MainActnBtn(txt: "Inventory", actn: toInventoryScrn)
                MainActnBtn(txt: "Customer contacts", actn: toCustomerContactsScrn)
                MainActnBtn(txt: "Work records", actn: toWorkRecordsScrn)
                MainActnBtn(txt: "Settings", actn: navToSettingsScrn)
                
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
    
    private func toOrderManagementScrn() {
        navPath.append(Scrns.orderManagement)
    }
    
    private func toInventoryScrn() {
        navPath.append(Scrns.inventory)
    }
    
    private func toCustomerContactsScrn() {
        navPath.append(Scrns.customerContacts)
    }
    
    private func toWorkRecordsScrn() {
        navPath.append(Scrns.workRecords)
    }

    private func navToSettingsScrn() {
        navPath.append(Scrns.settings)
    }
}


