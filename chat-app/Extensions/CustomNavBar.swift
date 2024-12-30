//
//  CustomNavBar.swift
//  Mock
//
//  Created by DungHM on 13/12/24.
//

import Foundation

enum CustomNavBar {
    case home
    case category
    case profile
    case forgotPassword
    case map
    
    var title: String {
        switch self {
        case .home:
            return "tab_title_home".localized()
        case .category:
            return "tab_title_category".localized()
        case .profile:
            return "tab_title_profile".localized()
        case .forgotPassword:
            return "tab_title_forgot_password".localized()
        case .map:
            return "tab_title_map".localized()
        }
    }
    
    var search: Bool {
        switch self {
        case .home:
            return false
        case .category:
            return true
        case .profile:
            return false
        case .forgotPassword:
            return false
        case .map:
            return false
        }
    }
    
    var back: Bool {
        switch self {
        case .home:
            return false
        case .category:
            return false
        case .profile:
            return false
        case .forgotPassword:
            return true
        case .map:
            return false
        }
    }
}
