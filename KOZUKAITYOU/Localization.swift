import Foundation

enum Language {
    case japanese
    case english

    static var current: Language {
        if Locale.current.languageCode == "ja" {
            return .japanese
        } else {
            return .english
        }
    }
}

func localized(japanese: String, english: String) -> String {
    switch Language.current {
    case .japanese:
        return japanese
    case .english:
        return english
    }
}
