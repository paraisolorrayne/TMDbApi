//
//  UITableViewCellExtension.swift
//  POC4VEngine
//
//  Created by Rodolfo Antonici on 23/09/17.
//  Copyright © 2017 Rodolfo Antonici. All rights reserved.
//

import UIKit


extension UITableViewCell {
    public struct Identifier: RawRepresentable, Equatable, Hashable {
        
        public let rawValue: String
        public var hashValue: Int {
            return rawValue.hashValue
        }
        
        //RawRepresentable
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
        
        //Equatable
        public static func ==(lhs: UITableViewCell.Identifier, rhs: UITableViewCell.Identifier) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
}
