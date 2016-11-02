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
    var webViews: [WKWebView] = []

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


/*
---------------------------------------------------------------------------
 Tab分のViewを作成し、重ねておくのではなく、必要時（Tabがタップされた時）に現在のWKWebViewをViewからremoveし、
 対象のWKWebViewをaddする。
 対象のWKWebViewは、新規タブで開くをタップされた際に、別スレッドでロードまでしておく。
 新規タブで開ける数は固定で、配列を作成し、そこにあらかじめWKWebViewを生成して格納しておく？
 で、URLを変えて使い回すイメージかな？
 タブ（ボタン）は動的生成で、tagとWKWebViewのインデックスを紐付けるイメージか？

- 新規タブで開くがタップされる
- タブ（UIButton）生成（tagに自動採番） → ScrollViewに追加していくイメージか？
- WKWebViewの辞書の要素数の閾値をチェック → 開けるタブ数の制限
- WKWebViewの辞書にtagの値でWKWebViewオブジェクトを追加
- 別スレッドでロード
- タブがタップされたら、そのタブ.tagの値でWKWebView辞書から取得
- 現在のWebViewをremoveし、取得したWebViewをadd
---------------------------------------------------------------------------
*/

/*
 現状 : WKWebViewを３つ生成しておき、各URLを別スレッドでロードしておく。
 ボタンタップで対応したWebViewをaddする仕掛け。
 WKWebViewの別スレッドロードと、remove / addの確認用。
*/
        // Tab分のWKWebViewを作成
        for _ in 0...2 {
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.allowsInlineMediaPlayback = true

            let item = WKWebView(frame: basedView.bounds, configuration: webConfiguration)
            item.uiDelegate = self
            item.navigationDelegate = self
            item.allowsBackForwardNavigationGestures = true
            item.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            webViews.append(item)
        }

        // 別スレッドで、Tab分のWKWebViewにURLをロード
        DispatchQueue.global(qos: .default).async {
            for i in 0...2 {
                var url = URL(string: "")
                if i == 0 {
                    url = URL(string: "http://codezine.jp/")
                }
                else if i == 1 {
                    url = URL(string: "http://www.itmedia.co.jp/")
                }
                else {
                    url = URL(string: "http://jp.techcrunch.com/")
                }
                let req = URLRequest(url: url!)
                var _ = self.webViews[i].load(req)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tappedTabButton(_ sender: UIButton) {
        // baseViewにのってるwebViewを削除
        for subView in basedView.subviews {
            subView.removeFromSuperview()
        }

        // 押されてたタブボタン.tagの値のwebViewをadd
        switch sender.tag {
        case 1:
            basedView.addSubview(webViews[0])
        case 2:
            basedView.addSubview(webViews[1])
        case 3:
            basedView.addSubview(webViews[2])
        default:
            break
        }
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

