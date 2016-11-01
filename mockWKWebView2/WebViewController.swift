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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        var _ = webView?.reloadFromOrigin()
    }


/*
    // webViewのAutolayout制約の作成
    func setupWebViewConstraints() {
        webView?.topAnchor.constraint(equalTo: basedView.topAnchor).isActive = true
        webView?.leadingAnchor.constraint(equalTo: basedView.leadingAnchor).isActive = true
        webView?.trailingAnchor.constraint(equalTo: basedView.trailingAnchor).isActive = true
        webView?.bottomAnchor.constraint(equalTo: basedView.bottomAnchor).isActive = true
    }

    func addViewportString() {
        var scriptContent = "var meta = document.createElement('meta');"
        scriptContent += "meta.name='viewport';"
        scriptContent += "meta.content='width=device-width,initial-scale=1';"
        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"

        webView?.evaluateJavaScript(scriptContent, completionHandler: nil)
    }
*/
}

