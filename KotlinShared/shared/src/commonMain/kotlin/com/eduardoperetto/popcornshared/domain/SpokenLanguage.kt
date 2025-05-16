package com.eduardoperetto.popcornshared.domain

enum class SpokenLanguage(val code: String, val displayName: String) : SelectionPickable {
    ar("ar", "العربية"),
    bn("bn", "বাংলা"),
    zh("zh", "普通话"),
    nl("nl", "Nederlands"),
    en("en", "English"),
    fr("fr", "Français"),
    de("de", "Deutsch"),
    el("el", "ελληνικά"),
    he("he", "עִבְרִית"),
    hi("hi", "हिन्दी"),
    hu("hu", "Magyar"),
    id("id", "Bahasa indonesia"),
    it("it", "Italiano"),
    ja("ja", "日本語"),
    ko("ko", "한국어/조선말"),
    ms("ms", "Bahasa melayu"),
    fa("fa", "فارسی"),
    pl("pl", "Polski"),
    pt("pt", "Português"),
    ru("ru", "Pусский"),
    es("es", "Español"),
    sw("sw", "Kiswahili"),
    sv("sv", "svenska"),
    ta("ta", "தமிழ்"),
    tr("tr", "Türkçe"),
    uk("uk", "Український"),
    ur("ur", "اردو"),
    vi("vi", "Tiếng Việt");

    companion object {
        fun fromCode(code: String?): SpokenLanguage? = code?.let { c -> entries.find { it.code == c } }
    }
}