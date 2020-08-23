//
//  NewsParser.swift
//  MyNewsApp
//
//  Created by User on 2020/07/04.
//  Copyright © 2020 Yusaku Kuwahata. All rights reserved.
//

import Foundation
import UIKit

class NewsParser {
    static let shared = NewsParser()
    var parser = XMLParser()
    
    func startDownLoad(url: String, delegate: XMLParserDelegate) {
        if let url = URL(string: url) {
            if let parser = XMLParser(contentsOf: url) {
                self.parser = parser
                self.parser.delegate = delegate
                self.parser.parse()
            }
        }
    }
}
