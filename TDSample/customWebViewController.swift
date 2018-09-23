//
//  customWebViewController.swift
//  TDSample
//
//  Created by Lingfei Gao on 2018/9/23.
//  Copyright © 2018年 Lingfei Gao. All rights reserved.
//

import UIKit
import WebKit
class customWebViewController: UIViewController, WKUIDelegate {
    var url = ""
    @IBOutlet weak var customWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customWebView.uiDelegate = self
        customWebView.load(URLRequest(url: URL(string: url)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismissButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
