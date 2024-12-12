//
//  PreloadedDatabase.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class PreloadedDatabase {
    
    static func getStyles () -> [Style] {
        var list: [Style] = []
        
        for i in 0..<2 {
            list.append(getStyleId(id: i))
        }
        
        return list
    }
    
    static func getStyleId (id: Int) -> Style {
        switch id {
        case 0:
            return Style(id: 0, name: "style_a_name", description: "style_a_description", hasAdditionalBlock: true, margins: 16, fontHeader: 13, fontText: 11, sizeName: 28, sizeHeader: 11, sizeText: 8, isHeaderBold: true, isHeaderUppercased: true, isHeaderItalic: false, isHeaderDotAdded: false, isHeaderLineAdded: false, headerLinePosition: 0, lineCirclesAdded: false, cornersRadius: 12, strokeWidth: 2, lineWidth: 3, dotSize: 4, dotBackAdded: true, dotStrokeAdded: false, progressBarStyle: 1, progressBarPercentAdded: false, iconSize: 18, iconBackAdded: true, iconStrokeAdded: false, iconIsBold: false, chipBackAdded: true, chipStrokeAdded: false, photoZoom: 1.1, photoFilterEnabled: false, photoStrokeAdded: false, profileDescHeaderAdded: true, profileDescHeaderPosition: 1, profileDescQuotesAdded: false, contactIconAdded: true, contactHeaderAdded: true, contactHeaderPosition: 1, socialIconAdded: true, socialHeaderPosition: 1, qrBackAdded: false, educationDateWithHeader: true, educationDateAfterHeader: false, educationDateSeparated: false, educationDateInBrackets: false, educationMonthDisplayed: false, educationDotsAdded: false, educationDescritpionAsBulleted: false, educationHeaderPosition: 1, workDateWithHeader: true, workDateAfterHeader: false, workDateSeparated: false, workDateInBrackets: false, workMonthDisplayed: false, workDotsAdded: false, workDescritpionAsBulleted: false, workHeaderPosition: 1, languagesIsBulletedList: false, languagesIsProgressAdded: true, languagesIconAdded: true, languagesHeaderPosition: 1, skillsIsBulletedList: true, skillsIsChips: false, skillsIsProgressAdded: false, skillsHeaderPosition: 1, interestsIsBulletedList: true, interestsIsChips: true, interestsHeaderPosition: 1, certificatesIsBulletedList: true, certificatesHeaderPosition: 1, referencesIsBulletedList: true, referencesHeaderPosition: 1, palettes: getPalettesByStyleId(id: 0))
        case 1:
            return Style(id: 1, name: "style_b_name", description: "style_b_description", hasAdditionalBlock: true, margins: 16, fontHeader: 3, fontText: 15, sizeName: 54, sizeHeader: 16, sizeText: 9, isHeaderBold: true, isHeaderUppercased: true, isHeaderItalic: true, isHeaderDotAdded: false, isHeaderLineAdded: true, headerLinePosition: 0, lineCirclesAdded: false, cornersRadius: 0, strokeWidth: 1, lineWidth: 1, dotSize: 3, dotBackAdded: true, dotStrokeAdded: false, progressBarStyle: 1, progressBarPercentAdded: true, iconSize: 20, iconBackAdded: false, iconStrokeAdded: true, iconIsBold: false, chipBackAdded: false, chipStrokeAdded: true, photoZoom: 1.0, photoFilterEnabled: false, photoStrokeAdded: false, profileDescHeaderAdded: false, profileDescHeaderPosition: 0, profileDescQuotesAdded: false, contactIconAdded: false, contactHeaderAdded: false, contactHeaderPosition: 0, socialIconAdded: false, socialHeaderPosition: 0, qrBackAdded: false, educationDateWithHeader: true, educationDateAfterHeader: true, educationDateSeparated: false, educationDateInBrackets: false, educationMonthDisplayed: false, educationDotsAdded: false, educationDescritpionAsBulleted: false, educationHeaderPosition: 0, workDateWithHeader: true, workDateAfterHeader: true, workDateSeparated: false, workDateInBrackets: false, workMonthDisplayed: false, workDotsAdded: false, workDescritpionAsBulleted: false, workHeaderPosition: 0, languagesIsBulletedList: true, languagesIsProgressAdded: true, languagesIconAdded: false, languagesHeaderPosition: 0, skillsIsBulletedList: true, skillsIsChips: false, skillsIsProgressAdded: true, skillsHeaderPosition: 0, interestsIsBulletedList: true, interestsIsChips: false, interestsHeaderPosition: 0, certificatesIsBulletedList: true, certificatesHeaderPosition: 0, referencesIsBulletedList: true, referencesHeaderPosition: 0, palettes: getPalettesByStyleId(id: 1))
        default:
            return Style(id: 0, name: "style_a_name", description: "style_a_description", hasAdditionalBlock: true, margins: 16, fontHeader: 13, fontText: 11, sizeName: 28, sizeHeader: 11, sizeText: 8, isHeaderBold: true, isHeaderUppercased: true, isHeaderItalic: false, isHeaderDotAdded: false, isHeaderLineAdded: false, headerLinePosition: 0, lineCirclesAdded: false, cornersRadius: 12, strokeWidth: 2, lineWidth: 3, dotSize: 4, dotBackAdded: true, dotStrokeAdded: false, progressBarStyle: 1, progressBarPercentAdded: false, iconSize: 18, iconBackAdded: true, iconStrokeAdded: false, iconIsBold: false, chipBackAdded: true, chipStrokeAdded: false, photoZoom: 1.1, photoFilterEnabled: false, photoStrokeAdded: false, profileDescHeaderAdded: true, profileDescHeaderPosition: 0, profileDescQuotesAdded: false, contactIconAdded: true, contactHeaderAdded: true, contactHeaderPosition: 0, socialIconAdded: true, socialHeaderPosition: 0, qrBackAdded: false, educationDateWithHeader: true, educationDateAfterHeader: false, educationDateSeparated: false, educationDateInBrackets: false, educationMonthDisplayed: false, educationDotsAdded: false, educationDescritpionAsBulleted: false, educationHeaderPosition: 1, workDateWithHeader: true, workDateAfterHeader: false, workDateSeparated: false, workDateInBrackets: false, workMonthDisplayed: false, workDotsAdded: false, workDescritpionAsBulleted: false, workHeaderPosition: 1, languagesIsBulletedList: false, languagesIsProgressAdded: true, languagesIconAdded: true, languagesHeaderPosition: 0, skillsIsBulletedList: true, skillsIsChips: false, skillsIsProgressAdded: false, skillsHeaderPosition: 0, interestsIsBulletedList: true, interestsIsChips: true, interestsHeaderPosition: 0, certificatesIsBulletedList: true, certificatesHeaderPosition: 0, referencesIsBulletedList: true, referencesHeaderPosition: 0, palettes: getPalettesByStyleId(id: 0))
        }
    }
    
    static func getPalettesByStyleId (id: Int) -> [Palette] {
        var palettes: [Palette] = []
        switch id {
        case 0:
            palettes.append(Palette(mainColor: "#F24C18", headerTextColor: "#191919", mainTextColor: "#191919", iconColor: "#F24C18", iconBackgroundColor: "#EEEEEE", iconStrokeColor: "#191919", lineColor: "#191919", lineCirclesColor: "#EEEEEE", dotColor: "#F24C18", dotStrokeColor: "#EEEEEE", qrForegroundColor: "#191919", qrBackgroundColor: "#F0F0F0", progressForegroundColor: "#F24C18", progressBackgroundColor: "#EEEEEE", chipTextColor: "#FFFFFF", chipBackgroundColor: "#F24C18", chipStrokeColor: "#EEEEEE"))
            palettes.append(Palette(mainColor: "#E585CC", headerTextColor: "#191919", mainTextColor: "#191919", iconColor: "#E585CC", iconBackgroundColor: "#EEEEEE", iconStrokeColor: "#191919", lineColor: "#191919", lineCirclesColor: "#EEEEEE", dotColor: "#E585CC", dotStrokeColor: "#EEEEEE", qrForegroundColor: "#191919", qrBackgroundColor: "#F0F0F0", progressForegroundColor: "#E585CC", progressBackgroundColor: "#EEEEEE", chipTextColor: "#FFFFFF", chipBackgroundColor: "#E585CC", chipStrokeColor: "#EEEEEE"))
            palettes.append(Palette(mainColor: "#1C58CC", headerTextColor: "#191919", mainTextColor: "#191919", iconColor: "#1C58CC", iconBackgroundColor: "#EEEEEE", iconStrokeColor: "#191919", lineColor: "#191919", lineCirclesColor: "#EEEEEE", dotColor: "#1C58CC", dotStrokeColor: "#EEEEEE", qrForegroundColor: "#191919", qrBackgroundColor: "#F0F0F0", progressForegroundColor: "#1C58CC", progressBackgroundColor: "#EEEEEE", chipTextColor: "#FFFFFF", chipBackgroundColor: "#1C58CC", chipStrokeColor: "#EEEEEE"))
            palettes.append(Palette(mainColor: "#1CA8A1", headerTextColor: "#191919", mainTextColor: "#191919", iconColor: "#1CA8A1", iconBackgroundColor: "#EEEEEE", iconStrokeColor: "#191919", lineColor: "#191919", lineCirclesColor: "#EEEEEE", dotColor: "#1CA8A1", dotStrokeColor: "#EEEEEE", qrForegroundColor: "#191919", qrBackgroundColor: "#F0F0F0", progressForegroundColor: "#1CA8A1", progressBackgroundColor: "#EEEEEE", chipTextColor: "#FFFFFF", chipBackgroundColor: "#1CA8A1", chipStrokeColor: "#EEEEEE"))
            palettes.append(Palette(mainColor: "#1781A1", headerTextColor: "#191919", mainTextColor: "#191919", iconColor: "#1781A1", iconBackgroundColor: "#EEEEEE", iconStrokeColor: "#191919", lineColor: "#191919", lineCirclesColor: "#EEEEEE", dotColor: "#1781A1", dotStrokeColor: "#EEEEEE", qrForegroundColor: "#191919", qrBackgroundColor: "#F0F0F0", progressForegroundColor: "#1781A1", progressBackgroundColor: "#EEEEEE", chipTextColor: "#FFFFFF", chipBackgroundColor: "#1781A1", chipStrokeColor: "#EEEEEE"))
            palettes.append(Palette(mainColor: "#4733A1", headerTextColor: "#191919", mainTextColor: "#191919", iconColor: "#4733A1", iconBackgroundColor: "#EEEEEE", iconStrokeColor: "#191919", lineColor: "#191919", lineCirclesColor: "#EEEEEE", dotColor: "#4733A1", dotStrokeColor: "#EEEEEE", qrForegroundColor: "#191919", qrBackgroundColor: "#F0F0F0", progressForegroundColor: "#4733A1", progressBackgroundColor: "#EEEEEE", chipTextColor: "#FFFFFF", chipBackgroundColor: "#4733A1", chipStrokeColor: "#EEEEEE"))
        case 1:
            palettes.append(Palette(mainColor: "#F2F1ED", headerTextColor: "#000000", mainTextColor: "#000000", iconColor: "#000000", iconBackgroundColor: "#E5DBCF", iconStrokeColor: "#000000", lineColor: "#000000", lineCirclesColor: "#E5DBCF", dotColor: "#000000", dotStrokeColor: "E5DBCF", qrForegroundColor: "#000000", qrBackgroundColor: "#E5DBCF", progressForegroundColor: "#000000", progressBackgroundColor: "#E5DBCF", chipTextColor: "#000000", chipBackgroundColor: "#E5DBCF", chipStrokeColor: "#000000"))
            palettes.append(Palette(mainColor: "#F2EBED", headerTextColor: "#000000", mainTextColor: "#000000", iconColor: "#000000", iconBackgroundColor: "#EEE6E8", iconStrokeColor: "#000000", lineColor: "#000000", lineCirclesColor: "#EEE6E8", dotColor: "#000000", dotStrokeColor: "#EEE6E8", qrForegroundColor: "#000000", qrBackgroundColor: "#EEE6E8", progressForegroundColor: "#000000", progressBackgroundColor: "#EEE6E8", chipTextColor: "#000000", chipBackgroundColor: "#EEE6E8", chipStrokeColor: "#000000"))
            palettes.append(Palette(mainColor: "#F2EFF6", headerTextColor: "#000000", mainTextColor: "#000000", iconColor: "#000000", iconBackgroundColor: "#E4E5F0", iconStrokeColor: "#000000", lineColor: "#000000", lineCirclesColor: "#E4E5F0", dotColor: "#000000", dotStrokeColor: "#E4E5F0", qrForegroundColor: "#000000", qrBackgroundColor: "#E4E5F0", progressForegroundColor: "#000000", progressBackgroundColor: "#E4E5F0", chipTextColor: "#000000", chipBackgroundColor: "#E4E5F0", chipStrokeColor: "#000000"))
            palettes.append(Palette(mainColor: "#FBEFF6", headerTextColor: "#000000", mainTextColor: "#000000", iconColor: "#000000", iconBackgroundColor: "#F7DDEC", iconStrokeColor: "#000000", lineColor: "#000000", lineCirclesColor: "#F7DDEC", dotColor: "#000000", dotStrokeColor: "#F7DDEC", qrForegroundColor: "#000000", qrBackgroundColor: "#F7DDEC", progressForegroundColor: "#000000", progressBackgroundColor: "#F7DDEC", chipTextColor: "#000000", chipBackgroundColor: "#F7DDEC", chipStrokeColor: "#000000"))
            palettes.append(Palette(mainColor: "#F3F8E8", headerTextColor: "#000000", mainTextColor: "#000000", iconColor: "#000000", iconBackgroundColor: "#F2F4F8", iconStrokeColor: "#000000", lineColor: "#000000", lineCirclesColor: "#F2F4F8", dotColor: "#000000", dotStrokeColor: "#F2F4F8", qrForegroundColor: "#000000", qrBackgroundColor: "#F2F4F8", progressForegroundColor: "#000000", progressBackgroundColor: "#F2F4F8", chipTextColor: "#000000", chipBackgroundColor: "#F2F4F8", chipStrokeColor: "#000000"))
            palettes.append(Palette(mainColor: "#EDF1FF", headerTextColor: "#000000", mainTextColor: "#000000", iconColor: "#000000", iconBackgroundColor: "#E1E7FF", iconStrokeColor: "#000000", lineColor: "#000000", lineCirclesColor: "#E1E7FF", dotColor: "#000000", dotStrokeColor: "#E1E7FF", qrForegroundColor: "#000000", qrBackgroundColor: "#E1E7FF", progressForegroundColor: "#000000", progressBackgroundColor: "#E1E7FF", chipTextColor: "#000000", chipBackgroundColor: "#E1E7FF", chipStrokeColor: "#000000"))
        default:
            break
        }
        return palettes
    }
    
    static func getFonts () -> [Font] {
        var list: [Font] = []
        
        for i in 0..<30 {
            list.append(getFontId(id: i))
        }
        
        return list
    }
    
    static func getFontsByCategory (category: Int) -> [Font] {
        var list: [Font] = []
        
        switch category {
        case 0:
            for i in 6..<12 {
                list.append(getFontId(id: i))
            }
        case 1:
            for i in 0..<6 {
                list.append(getFontId(id: i))
            }
        case 2:
            for i in 12..<18 {
                list.append(getFontId(id: i))
            }
        case 3:
            for i in 18..<24 {
                list.append(getFontId(id: i))
            }
        case 4:
            for i in 24..<30 {
                list.append(getFontId(id: i))
            }
        default:
            break
        }
        
        return list
    }
    
    static func getFontId (id: Int) -> Font {
        switch id {
        case 0:
            return Font(id: 0, name: "font_a_name", category: 1, italic: 1)
        case 1:
            return Font(id: 1, name: "font_b_name", category: 1, italic: 1)
        case 2:
            return Font(id: 2, name: "font_c_name", category: 1, italic: 1)
        case 3:
            return Font(id: 3, name: "font_d_name", category: 1, italic: 1)
        case 4:
            return Font(id: 4, name: "font_e_name", category: 1, italic: 0)
        case 5:
            return Font(id: 5, name: "font_f_name", category: 1, italic: 0)
        case 6:
            return Font(id: 6, name: "font_g_name", category: 0, italic: 1)
        case 7:
            return Font(id: 7, name: "font_h_name", category: 0, italic: 1)
        case 8:
            return Font(id: 8, name: "font_i_name", category: 0, italic: 1)
        case 9:
            return Font(id: 9, name: "font_j_name", category: 0, italic: 1)
        case 10:
            return Font(id: 10, name: "font_k_name", category: 0, italic: 1)
        case 11:
            return Font(id: 11, name: "font_l_name", category: 0, italic: 1)
        case 12:
            return Font(id: 12, name: "font_m_name", category: 2, italic: 0)
        case 13:
            return Font(id: 13, name: "font_n_name", category: 2, italic: 1)
        case 14:
            return Font(id: 14, name: "font_o_name", category: 2, italic: 0)
        case 15:
            return Font(id: 15, name: "font_p_name", category: 2, italic: 1)
        case 16:
            return Font(id: 16, name: "font_q_name", category: 2, italic: 1)
        case 17:
            return Font(id: 17, name: "font_r_name", category: 2, italic: 0)
        case 18:
            return Font(id: 18, name: "font_s_name", category: 3, italic: 0)
        case 19:
            return Font(id: 19, name: "font_t_name", category: 3, italic: 1)
        case 20:
            return Font(id: 20, name: "font_u_name", category: 3, italic: 0)
        case 21:
            return Font(id: 21, name: "font_v_name", category: 3, italic: 0)
        case 22:
            return Font(id: 22, name: "font_w_name", category: 3, italic: 1)
        case 23:
            return Font(id: 23, name: "font_x_name", category: 3, italic: 0)
        case 24:
            return Font(id: 24, name: "font_y_name", category: 4, italic: 1)
        case 25:
            return Font(id: 25, name: "font_z_name", category: 4, italic: 1)
        case 26:
            return Font(id: 26, name: "font_aa_name", category: 4, italic: 1)
        case 27:
            return Font(id: 27, name: "font_ab_name", category: 4, italic: 1)
        case 28:
            return Font(id: 28, name: "font_ac_name", category: 4, italic: 1)
        case 29:
            return Font(id: 29, name: "font_ad_name", category: 4, italic: 1)
        default:
            return Font(id: 0, name: "font_a_name", category: 1, italic: 1)
        }
    }
    
    static func getLanguages () -> [Language] {
        var list: [Language] = []
        
        for i in 0..<27 {
            if let lang = getLanguageById(id: i) {
                list.append(lang)
            }
        }
        
        return list
    }
    
    static func getLanguageById (id: Int) -> Language? {
        switch id {
        case 0:
            return Language(langId: 0, name: NSLocalizedString("indonesian", comment: ""), icon: "id_flag_icon", key: "indonesian", isSelected: false)
        case 1:
            return Language(langId: 1, name: NSLocalizedString("catala", comment: ""), icon: "ca_flag_icon", key: "catalan", isSelected: false)
        case 2:
            return Language(langId: 2, name: NSLocalizedString("dansk", comment: ""), icon: "da_flag_icon", key: "danish", isSelected: false)
        case 3:
            return Language(langId: 3, name: NSLocalizedString("deutch", comment: ""), icon: "de_flag_icon", key: "german", isSelected: false)
        case 4:
            return Language(langId: 4, name: NSLocalizedString("english", comment: ""), icon: "en_flag_icon", key: "english", isSelected: false)
        case 5:
            return Language(langId: 5, name: NSLocalizedString("espanol", comment: ""), icon: "sp_flag_icon", key: "spanish", isSelected: false)
        case 6:
            return Language(langId: 6, name: NSLocalizedString("francais", comment: ""), icon: "fr_flag_icon", key: "french", isSelected: false)
        case 7:
            return Language(langId: 7, name: NSLocalizedString("italiano", comment: ""), icon: "it_flag_icon", key: "italian", isSelected: false)
        case 8:
            return Language(langId: 8, name: NSLocalizedString("magyar", comment: ""), icon: "hu_flag_icon", key: "hungarian", isSelected: false)
        case 9:
            return Language(langId: 9, name: NSLocalizedString("nederlands", comment: ""), icon: "ne_flag_icon", key: "dutch", isSelected: false)
        case 10:
            return Language(langId: 10, name: NSLocalizedString("norsk", comment: ""), icon: "no_flag_icon", key: "norwegian", isSelected: false)
        case 11:
            return Language(langId: 11, name: NSLocalizedString("polski", comment: ""), icon: "po_flag_icon", key: "polish", isSelected: false)
        case 12:
            return Language(langId: 12, name: NSLocalizedString("portugues", comment: ""), icon: "pr_flag_icon", key: "portuguese", isSelected: false)
        case 13:
            return Language(langId: 13, name: NSLocalizedString("romana", comment: ""), icon: "ro_flag_icon", key: "romanian", isSelected: false)
        case 14:
            return Language(langId: 14, name: NSLocalizedString("srpski", comment: ""), icon: "sr_flag_icon", key: "serbian", isSelected: false)
        case 15:
            return Language(langId: 15, name: NSLocalizedString("suomi", comment: ""), icon: "fi_flag_icon", key: "finnish", isSelected: false)
        case 16:
            return Language(langId: 16, name: NSLocalizedString("svenska", comment: ""), icon: "sl_flag_icon", key: "slovenian", isSelected: false)
        case 17:
            return Language(langId: 17, name: NSLocalizedString("tieng_viet", comment: ""), icon: "vi_flag_icon", key: "vietnamese", isSelected: false)
        case 18:
            return Language(langId: 18, name: NSLocalizedString("turkce", comment: ""), icon: "tu_flag_icon", key: "turkish", isSelected: false)
        case 19:
            return Language(langId: 19, name: NSLocalizedString("cestina", comment: ""), icon: "ch_flag_icon", key: "czech", isSelected: false)
        case 20:
            return Language(langId: 20, name: NSLocalizedString("ellinika", comment: ""), icon: "gr_flag_icon", key: "greek", isSelected: false)
        case 21:
            return Language(langId: 21, name: NSLocalizedString("ukrainian", comment: ""), icon: "uk_flag_icon", key: "ukrainian", isSelected: false)
        case 22:
            return Language(langId: 22, name: NSLocalizedString("hebrew", comment: ""), icon: "is_flag_icon", key: "hebrew", isSelected: false)
        case 23:
            return Language(langId: 23, name: NSLocalizedString("hindi", comment: ""), icon: "in_flag_icon", key: "hindi", isSelected: false)
        case 24:
            return Language(langId: 24, name: NSLocalizedString("chinese", comment: ""), icon: "cz_flag_icon", key: "chinese", isSelected: false)
        case 25:
            return Language(langId: 25, name: NSLocalizedString("japanese", comment: ""), icon: "jp_flag_icon", key: "japanese", isSelected: false)
        case 26:
            return Language(langId: 26, name: NSLocalizedString("korean", comment: ""), icon: "kr_flag_icon", key: "korean", isSelected: false)
        default:
            return nil
        }
    }
    
    static func getSocialMedia () -> [SocialMedia] {
        var list: [SocialMedia] = []
        
        for i in 0..<8 {
            if let item = getSocialMediaById(id: i) {
                list.append(item)
            }
        }
        if let item = getSocialMediaById(id: -1) {
            list.append(item)
        }
        
        return list
    }
    
    static func getSocialMediaById (id: Int) -> SocialMedia? {
        switch id {
        case 0:
            return SocialMedia(id: 0, name: NSLocalizedString("social_media_sug_0", comment: ""), icon: "linkedin_icon", isSelected: false)
        case 1:
            return SocialMedia(id: 1, name: NSLocalizedString("social_media_sug_1", comment: ""), icon: "facebook_icon", isSelected: false)
        case 2:
            return SocialMedia(id: 2, name: NSLocalizedString("social_media_sug_2", comment: ""), icon: "instagram_icon", isSelected: false)
        case 3:
            return SocialMedia(id: 3, name: NSLocalizedString("social_media_sug_3", comment: ""), icon: "youtube_icon", isSelected: false)
        case 4:
            return SocialMedia(id: 4, name: NSLocalizedString("social_media_sug_4", comment: ""), icon: "tik-tok_icon", isSelected: false)
        case 5:
            return SocialMedia(id: 5, name: NSLocalizedString("social_media_sug_5", comment: ""), icon: "snapchat_icon", isSelected: false)
        case 6:
            return SocialMedia(id: 6, name: NSLocalizedString("social_media_sug_6", comment: ""), icon: "twitter_icon", isSelected: false)
        case 7:
            return SocialMedia(id: 7, name: NSLocalizedString("social_media_sug_7", comment: ""), icon: "threads_icon", isSelected: false)
        default:
            return SocialMedia(id: -1, name: NSLocalizedString("social_media_sug_8", comment: ""), icon: "link.circle.fill", isSelected: false)
        }
    }
    
    static func getInterestsOne () -> [Interest] {
        var list: [Interest] = []
        list.append(Interest(name: NSLocalizedString("interests_sug_0", comment: ""), icon: "hat.widebrim.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_1", comment: ""), icon: "paintpalette.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_2", comment: ""), icon: "lamp.table.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_3", comment: ""), icon: "hammer.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_4", comment: ""), icon: "pencil.and.outline", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_5", comment: ""), icon: "network", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_6", comment: ""), icon: "screwdriver.fill", isSelected: false))
        return list
    }
    
    static func getInterestsTwo () -> [Interest] {
        var list: [Interest] = []
        list.append(Interest(name: NSLocalizedString("interests_sug_7", comment: ""), icon: "birthday.cake.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_8", comment: ""), icon: "cooktop.fill", isSelected: false))
        return list
    }
    
    static func getInterestsThree () -> [Interest] {
        var list: [Interest] = []
        list.append(Interest(name: NSLocalizedString("interests_sug_9", comment: ""), icon: "music.note", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_10", comment: ""), icon: "gamecontroller.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_11", comment: ""), icon: "book.pages.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_12", comment: ""), icon: "figure.dance", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_13", comment: ""), icon: "airplane", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_14", comment: ""), icon: "arcade.stick.console.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_15", comment: ""), icon: "camera.fill", isSelected: false))
        return list
    }
    
    static func getInterestsFour () -> [Interest] {
        var list: [Interest] = []
        list.append(Interest(name: NSLocalizedString("interests_sug_16", comment: ""), icon: "bicycle", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_17", comment: ""), icon: "water.waves", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_18", comment: ""), icon: "dumbbell.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_19", comment: ""), icon: "soccerball", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_20", comment: ""), icon: "mountain.2.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_21", comment: ""), icon: "camera.macro", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_22", comment: ""), icon: "figure.climbing", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_23", comment: ""), icon: "figure.skiing.crosscountry", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_24", comment: ""), icon: "snowboard.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_25", comment: ""), icon: "surfboard.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_26", comment: ""), icon: "figure.pool.swim", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_27", comment: ""), icon: "tennis.racket", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_28", comment: ""), icon: "volleyball.fill", isSelected: false))
        return list
    }
    
    static func getInterestsFive () -> [Interest] {
        var list: [Interest] = []
        list.append(Interest(name: NSLocalizedString("interests_sug_29", comment: ""), icon: "flame.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_30", comment: ""), icon: "fish.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_31", comment: ""), icon: "tree.fill", isSelected: false))
        return list
    }
    
    static func getInterestsSix () -> [Interest] {
        var list: [Interest] = []
        list.append(Interest(name: NSLocalizedString("interests_sug_32", comment: ""), icon: "apps.iphone", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_33", comment: ""), icon: "dollarsign.bank.building.fill", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_34", comment: ""), icon: "globe", isSelected: false))
        list.append(Interest(name: NSLocalizedString("interests_sug_35", comment: ""), icon: "message.badge.filled.fill", isSelected: false))
        return list
    }
    
    static func getExportQualityList (isUserPremium: Bool) -> [Quality] {
        var list: [Quality] = []
        list.append(Quality(id: 0, name: NSLocalizedString("quality_compressed", comment: ""), icon: "arrow.up.right.and.arrow.down.left.rectangle.fill", isPremium: false, isPremiumVisible: false, isSelected: false))
        list.append(Quality(id: 1, name: NSLocalizedString("quality_high", comment: ""), icon: "checkmark.seal.fill", isPremium: true, isPremiumVisible: !isUserPremium, isSelected: false))
        return list
    }
    
    static func getPhotoTips () -> [PhotoTip] {
        var list: [PhotoTip] = []
        list.append(PhotoTip(header: NSLocalizedString("photo_selection_tip_one_header", comment: ""), description: NSLocalizedString("photo_selection_tip_one_description", comment: ""), imageOne: "profile_photo_one_illustration", imageTwo: "", orientation: 0))
        list.append(PhotoTip(header: NSLocalizedString("photo_selection_tip_two_header", comment: ""), description: NSLocalizedString("photo_selection_tip_two_description", comment: ""), imageOne: "profile_photo_two_illustration", imageTwo: "", orientation: 1))
        list.append(PhotoTip(header: NSLocalizedString("photo_selection_tip_three_header", comment: ""), description: NSLocalizedString("photo_selection_tip_three_description", comment: ""), imageOne: "profile_photo_three_illustration", imageTwo: "", orientation: 0))
        return list
    }
    
    static func getPhotoMistakes () -> [PhotoTip] {
        var list: [PhotoTip] = []
        list.append(PhotoTip(header: NSLocalizedString("photo_selection_tip_four_header", comment: ""), description: "", imageOne: "profile_photo_four_illustration", imageTwo: "profile_photo_five_illustration", orientation: 0))
        list.append(PhotoTip(header: NSLocalizedString("photo_selection_tip_five_header", comment: ""), description: "", imageOne: "profile_photo_six_illustration", imageTwo: "profile_photo_seven_illustration", orientation: 1))
        list.append(PhotoTip(header: NSLocalizedString("photo_selection_tip_six_header", comment: ""), description: "", imageOne: "profile_photo_eight_illustration", imageTwo: "profile_photo_nine_illustration", orientation: 0))
        return list
    }
}