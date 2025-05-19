//
//  Image+Extension.swift
//  PhotoEase
//
//  Created by Tree Bui Quang Tri on 10/3/25.
//

import SwiftUI

extension Image {
    static let photo = "photo".systemImage
    static let personCircleFill = "person.circle.fill".systemImage
    static let chevronRight = "chevron.right".systemImage
    static let star = "star".systemImage
    static let starFill = "star.fill".systemImage
    static let mappinAndEllipse = "mappin.and.ellipse".systemImage
    static let person2Fill = "person.2.fill".systemImage
    static let medalFill = "medal.fill".systemImage
}

extension String {
    var systemImage: Image {
        Image(systemName: self)
    }
}
