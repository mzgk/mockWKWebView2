//
//  WebViewController.swift
//  mockWKWebView2
//
//  Created by mzgk on 2016/10/31.
//  Copyright © 2016年 mzgk. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var basedView: UIView!

    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // WebのATS無効化
        // Info.plist -> App Transport Security Settings -> Allow Arbitrary Loads in Web Content = YES
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true   // インライン動画再生
        webView = WKWebView(frame: basedView.bounds, configuration: webConfiguration)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.allowsBackForwardNavigationGestures = true
        webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let url = URL(string: "http://www.yahoo.co.jp/")
        let urlRequest = URLRequest(url: url!)
        var _ = webView?.load(urlRequest)

        basedView.addSubview(webView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*
    // webViewのAutolayout制約の作成
    func setupWebViewConstraints() {
        webView?.topAnchor.constraint(equalTo: basedView.topAnchor).isActive = true
        webView?.leadingAnchor.constraint(equalTo: basedView.leadingAnchor).isActive = true
        webView?.trailingAnchor.constraint(equalTo: basedView.trailingAnchor).isActive = true
        webView?.bottomAnchor.constraint(equalTo: basedView.bottomAnchor).isActive = true
    }
*/
}

