//
//  SpokenLanguage.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 10/05/25.
//

import Foundation

enum SpokenLanguage: String, SelectionPickable {
    case ar
    case bn
    case zh
    case nl
    case en
    case fr
    case de
    case el
    case he
    case hi
    case hu
    case id
    case it
    case ja
    case ko
    case ms
    case fa
    case pl
    case pt
    case ru
    case es
    case sw
    case sv
    case ta
    case tr
    case uk
    case ur
    case vi

    var id: String { rawValue }

    var name: String {
        switch self {
        case .ar: return "العربية"
        case .bn: return "বাংলা"
        case .zh: return "普通话"
        case .nl: return "Nederlands"
        case .en: return "English"
        case .fr: return "Français"
        case .de: return "Deutsch"
        case .el: return "ελληνικά"
        case .he: return "עִבְרִית"
        case .hi: return "हिन्दी"
        case .hu: return "Magyar"
        case .id: return "Bahasa indonesia"
        case .it: return "Italiano"
        case .ja: return "日本語"
        case .ko: return "한국어/조선말"
        case .ms: return "Bahasa melayu"
        case .fa: return "فارسی"
        case .pl: return "Polski"
        case .pt: return "Português"
        case .ru: return "Pусский"
        case .es: return "Español"
        case .sw: return "Kiswahili"
        case .sv: return "svenska"
        case .ta: return "தமிழ்"
        case .tr: return "Türkçe"
        case .uk: return "Український"
        case .ur: return "اردو"
        case .vi: return "Tiếng Việt"
        }
    }

    var description: String { englishName }

    var englishName: String {
        switch self {
        case .ar: return "Arabic"
        case .bn: return "Bengali"
        case .zh: return "Mandarin"
        case .nl: return "Dutch"
        case .en: return "English"
        case .fr: return "French"
        case .de: return "German"
        case .el: return "Greek"
        case .he: return "Hebrew"
        case .hi: return "Hindi"
        case .hu: return "Hungarian"
        case .id: return "Indonesian"
        case .it: return "Italian"
        case .ja: return "Japanese"
        case .ko: return "Korean"
        case .ms: return "Malay"
        case .fa: return "Persian"
        case .pl: return "Polish"
        case .pt: return "Portuguese"
        case .ru: return "Russian"
        case .es: return "Spanish"
        case .sw: return "Swahili"
        case .sv: return "Swedish"
        case .ta: return "Tamil"
        case .tr: return "Turkish"
        case .uk: return "Ukrainian"
        case .ur: return "Urdu"
        case .vi: return "Vietnamese"
        }
    }

    init?(isoCode: String?) {
        guard let isoCode = isoCode else { return nil }
        self.init(rawValue: isoCode)
    }
}
