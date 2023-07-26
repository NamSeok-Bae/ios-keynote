//
//  NotificiationName+.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/24.
//

import Foundation

extension Notification.Name {
    static let slideViewCreate = Notification.Name("SlideViewCreateNotification")
    static let slideViewAlphaUpdate = Notification.Name("SlideViewAlphaUpdateNotification")
    static let slideViewBackgroundColorUpdate = Notification.Name("SlideViewBackgroundColorUpdateNotification")
    static let slideViewMove = Notification.Name("SlideViewMoveNotification")
    static let slideViewImageStringUpdate = Notification.Name("SlideViewImageStringUpdateNotification")
    static let slideViewSizeUpdate = Notification.Name("SlideViewSizeUpdateNotification")
}
