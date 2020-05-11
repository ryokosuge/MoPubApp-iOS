//
//  BannerViewController.swift
//  MoPubApp
//
//  Created by ryokosuge on 2020/05/11.
//  Copyright © 2020 ryokosuge. All rights reserved.
//

import UIKit
import MoPub

class BannerViewController: UIViewController {

    private var adView: MPAdView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        loadAd()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        adView?.center = view.center
    }

}

extension BannerViewController {

    @IBAction func refresh(_ barButtonItem: UIBarButtonItem) {
        adView?.loadAd(withMaxAdSize: kMPPresetMaxAdSize50Height)
    }

    private func loadAd() {
        adView?.removeFromSuperview()
        adView = nil
        
        guard let adView = MPAdView(adUnitId: Consts.AdUnitID.banner) else {
            return
        }
        
        adView.delegate = self
        adView.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
        view.addSubview(adView)
        adView.loadAd(withMaxAdSize: kMPPresetMaxAdSize50Height)
        
        self.adView = adView
    }

}

extension BannerViewController: MPAdViewDelegate {

    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }

    func adViewDidLoadAd(_ view: MPAdView!, adSize: CGSize) {
        print(#function, view!, view!.adUnitId ?? "nil", adSize)
    }

    func adView(_ view: MPAdView!, didFailToLoadAdWithError error: Error!) {
        print(#function, view!, view!.adUnitId ?? "nil", error.localizedDescription)
    }

    func didDismissModalView(forAd view: MPAdView!) {
        print(#function, view!, view!.adUnitId ?? "nil")
    }

    func willPresentModalView(forAd view: MPAdView!) {
        print(#function, view!, view!.adUnitId ?? "nil")
    }

    func willLeaveApplication(fromAd view: MPAdView!) {
        print(#function, view!, view!.adUnitId ?? "nil")
    }

}