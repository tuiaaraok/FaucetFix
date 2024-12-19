import SwiftUI

@available(iOS 16.0, *)
struct HomeFlow: View {
    @State var navPath: [Scrns] = []
    
    var body: some View {
        NavigationStack(path: $navPath) {
            HomeScrn(navPath: $navPath)
                .navigationDestination(for: Scrns.self) { scrn in
                    switch scrn {
                    case .home:
                        HomeScrn(navPath: $navPath)
                    case .orderManagement:
                        OrderManagementScrn(navPath: $navPath)
                    case .orderCreating:
                        OrderCreatingScrn(navPath: $navPath)
                    case .inventory:
                        InventoryScrn(navPath: $navPath)
                    case .stockAdding:
                        StockAddingScrn(navPath: $navPath)
                    case .customerContacts:
                        CustomerContactsScrn(navPath: $navPath)
                    case .contactAdding:
                        ContactAddingScrn(navPath: $navPath)
                    case .workRecords:
                        WorkRecordsScrn(navPath: $navPath)
                    case .entryAdding:
                        EntryAddingScrn(navPath: $navPath)
                    case .settings:
                        SettingsScrn(navPath: $navPath)
                    }
                }
        }
    }
}

enum Scrns: Hashable {
    case home
    case orderManagement
    case orderCreating
    case inventory
    case stockAdding
    case customerContacts
    case contactAdding
    case workRecords
    case entryAdding
    case settings
}
