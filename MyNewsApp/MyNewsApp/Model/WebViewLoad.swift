//
//  WebViewLoad.swift
//  MyNewsApp
//
//  Created by User on 2020/07/05.
//  Copyright © 2020 Yusaku Kuwahata. All rights reserved.
//

import Foundation

class WebViewLoad {
    
    static let shared = WebViewLoad()
    
    func webViewLoad(urlString: String, completion: ((URLRequest) -> Void)) {
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedUrlString!)
        let request = URLRequest(url: url!)
        completion(request)
    }
    
}
