//
//  StoryboardInitializable.swift
//  Ruti
//
//  Created by leeyeon2 on 6/9/24.
//

import Foundation
import UIKit

protocol StoryboardInitializable: AnyObject {
    static var storyboardName: String { get set }
    static var storyboardID: String { get set }
    static func instantiate() -> Self
}

extension StoryboardInitializable where Self: UIViewController {
    static var storyboardID: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        if #available(iOS 13.0, *) {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
            return storyboard.instantiateViewController(identifier: storyboardID) { (coder) -> Self? in
                return Self(coder: coder)
            }
        } else {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: storyboardID) as! Self
            return vc
        }
    }
}
