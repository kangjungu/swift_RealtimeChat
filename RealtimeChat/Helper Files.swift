//
//  Helper Files.swift
//  RealtimeChat
//
//  Created by jG on 2017. 5. 17..
//  Copyright © 2017년 KangJungu. All rights reserved.
//

import Foundation
import UIKit

struct GlobalVariables {
    static let blue = UIColor.rgb(r: 129, g: 144, b: 255)
    static let purple = UIColor.rgb(r: 161, g: 114, b: 255)
}

extension UIColor{
    class func rgb(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}

class RoundImageView:UIImageView{
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius:CGFloat = self.bounds.width/2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class RoudnButton:UIButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius:CGFloat = self.bounds.size.height / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

enum ViewControllerType{
    case welcome
    case conversations
}

enum PhotoSource{
    case library
    case camera
}

enum ShowExtraView{
    case contacts
    case profile
    case preview
    case map
}

enum MessageType{
    case photo
    case text
    case location
}

enum MessageOwner{
    case sender
    case receiver
}
