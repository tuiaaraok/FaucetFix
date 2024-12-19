import Foundation
import WebKit
import SwiftUI
import FirebaseRemoteConfig
import Network

enum NavigationState {
    case homeFlow, serviceScreen
}

struct PersistentStorage {
    
    static let sharedInstance = PersistentStorage()
    
    private init() { }
    
    @AppStorage("APP_URL") private var appURL = ""
    @AppStorage("IS_FIRST_TIME") private var isFirstTime = true
    
    func getAppURL() -> String {
        appURL
    }
    
    func setAppURL(_ url: String) {
        appURL = url
    }
    
    func isFirstLaunch() -> Bool {
        isFirstTime
    }
    
    func setFirstLaunch(_ value: Bool) {
        isFirstTime = value
    }
}

class WebViewManager: ObservableObject {
    @Published var navigationState: NavigationState = .serviceScreen
    @Published var displayAlert: Bool = false
    @Published var loadedURL: String?
    @Published var displayAgreeButton = false
    
    func fetchRemoteConfig() async -> URL? {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        do {
            let status = try await remoteConfig.fetchAndActivate()
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                let urlString = remoteConfig["privacyLink"].stringValue ?? ""
                guard let url = URL(string: urlString) else { return nil }
                return url
            }
        } catch {
            navigationState = .homeFlow
        }
        return nil
    }
}

@available(iOS 17.0, *)
struct PrivacyWebView: View {
    @StateObject var viewModel = WebViewManager()
    
    var body: some View {
        Group {
            switch viewModel.navigationState {
            case .homeFlow:
                HomeFlow()
            case .serviceScreen:
                VStack {
                    if let url = viewModel.loadedURL {
                        WebView(url: url, viewModel: viewModel)
                    }
                    if viewModel.displayAgreeButton {
                        Button(action: {
                            viewModel.navigationState = .homeFlow
                        }, label: {
                            Text("Agree")
                                .customFont(.mainActnBtnTxt)
                                .foregroundStyle(Color.white)
                                .padding(EdgeInsets(top: 7, leading: 42, bottom: 7, trailing: 42))
                                .background(Color.mainAdd)
                                .cornerRadius(20)
                        })
                    }
                }
            }
        }
        .alert("No internet", isPresented: $viewModel.displayAlert, actions: {
            Button(role: .cancel, action: {}, label: {
                Text("Ok")
            })
        })
        .onAppear(perform: configureView)
    }
    
    private func configureView() {
        let storage = PersistentStorage.sharedInstance
        if !storage.getAppURL().isEmpty {
            viewModel.loadedURL = storage.getAppURL()
            viewModel.navigationState = .serviceScreen
        } else if storage.isFirstLaunch() {
            Task {
                if let url = await viewModel.fetchRemoteConfig() {
                    viewModel.loadedURL = url.absoluteString
                    viewModel.navigationState = .serviceScreen
                }
            }
            storage.setFirstLaunch(false)
        } else {
            viewModel.navigationState = .homeFlow
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: String
    let viewModel: WebViewManager
    private let userAgent = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(UIDevice.current.model) OS \(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(UIDevice.current.systemVersion) Mobile/15E148 Safari/604.1"
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else { return WKWebView() }
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.customUserAgent = userAgent
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }
            
            if handleCustomSchemes(url: url) {
                decisionHandler(.cancel)
                return
            }
            
            if url.query?.contains("showAgreebutton") == true {
                parent.viewModel.displayAgreeButton = true
            } else {
                let storage = PersistentStorage.sharedInstance
                storage.setAppURL(parent.viewModel.displayAgreeButton ? "" : url.absoluteString)
            }
            
            decisionHandler(.allow)
        }
        
        private func handleCustomSchemes(url: URL) -> Bool {
            let schemes = ["tel", "mailto", "tg", "phonepe", "paytmmp"]
            guard schemes.contains(url.scheme ?? "") else { return false }
            UIApplication.shared.open(url, options: [:])
            return true
        }
    }
}
