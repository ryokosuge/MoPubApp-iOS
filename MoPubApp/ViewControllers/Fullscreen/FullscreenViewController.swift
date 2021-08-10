//
//  FullscreenViewController.swift
//  MoPubApp
//
//  Created by ryokosuge on 2020/04/07.
//  Copyright © 2020 ryokosuge. All rights reserved.
//

import UIKit
import MoPubSDK

class FullscreenViewController: UIViewController {

    @IBOutlet weak var loadButton: UIButton?
    @IBOutlet weak var showButton: UIButton?

    private var interstitialAd: MPInterstitialAdController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showButton?.isEnabled = false
    }

}

// MARK: - Interface Builder Action

extension FullscreenViewController {

    @IBAction func loadAd(_ button: UIButton) {
        showActivityIndicator()
        loadButton?.isEnabled = false
        showButton?.isEnabled = false
        self.interstitialAd = MPInterstitialAdController(forAdUnitId: Consts.AdUnitID.fullscreen)
        self.interstitialAd?.delegate = self
        self.interstitialAd?.loadAd()
    }

    @IBAction func showAd(_ button: UIButton) {
        guard let interstitialAd = self.interstitialAd, interstitialAd.ready else {
            return
        }

        interstitialAd.show(from: self)
    }

}

// MARK: -
extension FullscreenViewController: MPInterstitialAdControllerDelegate {

    func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
        hideActivityIndicator()
        loadButton?.isEnabled = true
        showButton?.isEnabled = true
    }

    func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController!, withError error: Error!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "", error.localizedDescription)
        hideActivityIndicator()
        showAlert(message: error.localizedDescription)
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func interstitialWillAppear(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
    }

    func interstitialDidAppear(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
    }

    func interstitialDidExpire(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
    }

    func interstitialDidReceiveTapEvent(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
    }

    func interstitialWillDisappear(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
    }

    func interstitialDidDisappear(_ interstitial: MPInterstitialAdController!) {
        print("[MoPubApp]", #function, interstitial.adUnitId ?? "")
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

}

// MARK: - private

extension FullscreenViewController {

    private func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = barButton
    }

    private func hideActivityIndicator() {
        navigationItem.rightBarButtonItem = nil
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "閉じる", style: .default, handler: nil)
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
    }

}
