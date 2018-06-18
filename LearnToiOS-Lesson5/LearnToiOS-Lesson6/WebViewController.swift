//
//  WebViewController.swift
//  LearnToiOS-Lesson5
//
//  Created by Jack Spargo on 09/06/2018.
//  Copyright © 2018 LearnTo iOS. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var url: String = ""
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
//        if let url = URL(string: url) {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
        let htmlString = "<h1>Hello World!</h2><marquee>LearnTo iOS - Lesson 5</marquee>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
}
