//
//  WebViewController.swift
//  MyNewsApp
//
//  Created by User on 2020/07/05.
//  Copyright © 2020 Yusaku Kuwahata. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var urlString = ""
    var webViewTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = webViewTitle
//        WebViewLoad.shared.webViewLoad(urlString: urlString) { (request) in
//            self.webView.load(request)
//        }
        
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedUrlString!)
        let request = URLRequest(url: url!)
        webView.load(request)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
