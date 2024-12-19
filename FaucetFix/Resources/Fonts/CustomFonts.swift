import Foundation
import SwiftUI

enum CustomFonts: String {
    case roboto = "Roboto"
}

struct FontBuilder {
    
    let font: Font
    let tracking: Double
    let lineSpacing: Double
    let verticalPadding: Double
    
    init(
        customFont: CustomFonts,
        fontSize: Double,
        weight: Font.Weight = .regular,
        letterSpacing: Double = 0,
        lineHeight: Double
    ) {
        self.font = Font.custom(customFont, size: fontSize).weight(weight)
        self.tracking = fontSize * letterSpacing

        let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.verticalPadding = self.lineSpacing / 2
    }
    
}

extension FontBuilder {
    
    static let toolsTtlTxt = FontBuilder(
        customFont: .roboto,
        fontSize: 22,
        weight: .medium,
        lineHeight: 24
    )
    
    static let infTxt = FontBuilder(
        customFont: .roboto,
        fontSize: 16,
        weight: .regular,
        lineHeight: 19
    )
    
    static let actnBtnsTxt = FontBuilder(
        customFont: .roboto,
        fontSize: 22,
        weight: .semibold,
        lineHeight: 26
    )
    
    static let addActnBtnTxt = FontBuilder(
        customFont: .roboto,
        fontSize: 20,
        weight: .medium,
        lineHeight: 24
    )

    static let mainActnBtnTxt = FontBuilder(
        customFont: .roboto,
        fontSize: 24,
        weight: .medium,
        lineHeight: 29
    )
    
}


extension Font {
    static func custom(_ fontName: CustomFonts, size: Double) -> Font {
        Font.custom(fontName.rawValue, size: size)
    }
}


@available(iOS 16.0, *)

struct CustomFontsModifire: ViewModifier {

    private let fontBuilder: FontBuilder

    init(_ fontBuilder: FontBuilder) {
        self.fontBuilder = fontBuilder
    }

    func body(content: Content) -> some View {
        content
            .font(fontBuilder.font)
            .lineSpacing(fontBuilder.lineSpacing)
            .padding([.vertical], fontBuilder.verticalPadding)
            .tracking(fontBuilder.tracking)
    }

}

@available(iOS 16.0, *)
extension View {
    func customFont(_ fontBuilder: FontBuilder) -> some View {
        modifier(CustomFontsModifire(fontBuilder))
    }
}
