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

        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: basedView.bounds, configuration: webConfiguration)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.allowsBackForwardNavigationGestures = true
        webView?.translatesAutoresizingMaskIntoConstraints = false

        let url = URL(string: "http://www.yahoo.co.jp")
        let urlRequest = URLRequest(url: url!)
        var _ = webView?.load(urlRequest)

        basedView.addSubview(webView!)

        setupWebViewCpnstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // webViewのAutolayout制約の作成
    func setupWebViewCpnstraints() {
        webView?.topAnchor.constraint(equalTo: basedView.topAnchor).isActive = true
        webView?.leadingAnchor.constraint(equalTo: basedView.leadingAnchor).isActive = true
        webView?.trailingAnchor.constraint(equalTo: basedView.trailingAnchor).isActive = true
        webView?.bottomAnchor.constraint(equalTo: basedView.bottomAnchor).isActive = true
    }

    // TODO: 横→縦に回転しときにViewの横幅が更新されない（縦→横は大丈夫）
}

