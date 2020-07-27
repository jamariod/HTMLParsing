//
//  ViewController.swift
//  HTMLParsing
//
//  Created by Jamario Davis on 7/26/20.
//

import UIKit
import HTMLKit
import WebKit

class ViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        return webView
    }()
    let urlString = "https://www.google.com/search?q=Coding&sxsrf=ALeKk03COpJoKlKvsIfFlehR9jq5hDHoKg:1595805660171&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiH44Ssh-zqAhVtdt8KHSvVB4QQ_AUoAXoECA4QAw&biw=826&bih=493"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.navigationDelegate = self
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // parsing
        parseImages()
    }
    func parseImages(){
        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
            guard let html = result as? String, error == nil else {
                return
            }
            let document = HTMLDocument(string: html)
            let images: [String] = document.querySelectorAll("img").compactMap({ element in
                guard let src = element.attributes["src"] as? String else {
                    return nil
                }
                return src
            })
            print("Found \(images.count) images")
            print(images)
            
        }
    }
}































































