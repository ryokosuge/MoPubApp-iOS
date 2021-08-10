//
//  RewardedVideoViewController.swift
//  MoPubApp
//
//  Created by ryokosuge on 2020/03/19.
//  Copyright © 2020 ryokosuge. All rights reserved.
//

import UIKit
import MoPubSDK

class RewardedVideoViewController: UIViewController {

    @IBOutlet weak var loadButton: UIButton?
    @IBOutlet weak var showButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showButton?.isEnabled = false
        MPRewardedAds.setDelegate(self, forAdUnitId: Consts.AdUnitID.rewardedVideo)
    }

}

// MARK: - Interface Builder Action

extension RewardedVideoViewController {

    @IBAction func loadAd(_ button: UIButton) {
        showActivityIndicator()
        loadButton?.isEnabled = false
        showButton?.isEnabled = false
        MPRewardedAds.loadRewardedAd(withAdUnitID: Consts.AdUnitID.rewardedVideo, withMediationSettings: [])
    }

    @IBAction func showAd(_ button: UIButton) {
        guard MPRewardedAds.hasAdAvailable(forAdUnitID: Consts.AdUnitID.rewardedVideo) else {
            return
        }

        let reward = MPRewardedAds.selectedReward(forAdUnitID: Consts.AdUnitID.rewardedVideo)
        MPRewardedAds.presentRewardedAd(forAdUnitID: Consts.AdUnitID.rewardedVideo,
                                        from: self,
                                        with: reward)
    }

}

// MARK: - MPRewardedVideo Delegate

extension RewardedVideoViewController: MPRewardedAdsDelegate {

    func rewardedAdDidLoad(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
        hideActivityIndicator()
        loadButton?.isEnabled = true
        showButton?.isEnabled = true
    }

    func rewardedAdDidFailToLoad(forAdUnitID adUnitID: String!, error: Error!) {
        print("[MoPubApp]", #function, adUnitID ?? "", error.localizedDescription)
        hideActivityIndicator()
        showAlert(message: error.localizedDescription)
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func rewardedAdWillPresent(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
    }

    func rewardedAdDidPresent(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
    }

    func rewardedAdDidFailToShow(forAdUnitID adUnitID: String!, error: Error!) {
        print("[MoPubApp]", #function, adUnitID ?? "", error.localizedDescription)
        showAlert(message: error.localizedDescription)
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func rewardedAdDidExpire(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
        showAlert(message: "expired")
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func rewardedAdDidReceiveTapEvent(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
    }

    func rewardedAdWillLeaveApplication(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
    }

    func rewardedAdShouldReward(forAdUnitID adUnitID: String!, reward: MPReward!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
        if let reward = reward {
            print("[MoPubApp]", "currencyType:    \(reward.currencyType ?? "")", "amount:    \(reward.amount.doubleValue)")
        }
    }

    func rewardedAdWillDismiss(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
    }

    func rewardedAdDidDismiss(forAdUnitID adUnitID: String!) {
        print("[MoPubApp]", #function, adUnitID ?? "")
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

}

// MARK: - private

extension RewardedVideoViewController {

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
