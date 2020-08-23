//
//  ViewController.swift
//  MyNewsApp
//
//  Created by User on 2020/07/04.
//  Copyright © 2020 Yusaku Kuwahata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    // ニュースの情報を配列で保持する
    var newsItemArray = [NewsItem]()
    var newsItem: NewsItem?
    let parserURL = "Https://www.apple.com/jp/newsroom/rss-feed.rss"
    var currentString = ""
    var entryChecking = false
    var sendURLString = ""
    var sendTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .systemTeal
        newsItemArray = []
        getNews()
        // Do any additional setup after loading the view.
    }
    
    // ニュースを取得するメソッド
    func getNews() {
        NewsParser.shared.startDownLoad(url: parserURL, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewController
        webVC.webViewTitle = sendTitle
        webVC.urlString = sendURLString
//        self.navigationController?.pushViewController(webVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItemArray.count
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ニュースの情報を取得後、セルのタイトルを設定する
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.text = newsItemArray[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sendURLString = newsItemArray[indexPath.row].link
        sendTitle = newsItemArray[indexPath.row].title
        performSegue(withIdentifier: "next", sender: nil)
    }
}

extension ViewController: XMLParserDelegate {
    
    // 要素名の開始タグが見つかるごとに毎回呼び出されるメソッド
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentString = ""
        if elementName == "entry" {
            self.newsItem = NewsItem()
            entryChecking = true
        }
        if let link = attributeDict["href"] {
            if entryChecking {
                self.currentString = link
            }
        }
    }
    
    // didStartElementで見つかった要素の内容が見つかったときに呼ばれる
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // 要素の内容をcurrentStringで保持する
        self.currentString += string
//        if self.currentString == "link" {
//            if entryChecking {
//                self.currentString = string
//                entryChecking = false
//            }
//        }
    }
    
    // 要素の終了タグが見つかったときに呼ばれるメソッド
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title":
            self.newsItem?.title = currentString
        case "link":
            if entryChecking {
                self.newsItem?.link = currentString
                entryChecking = false
            }
        case "entry":
            self.newsItemArray.append(self.newsItem!)
            entryChecking = false
        default:
            break
        }
    }
    
    // XMLファイルの解析が終了したときに呼ばれるメソッド
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
}
