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
        MPRewardedVideo.setDelegate(self, forAdUnitId: Consts.AdUnitID.rewardedVideo)
    }

}

// MARK: - Interface Builder Action

extension RewardedVideoViewController {

    @IBAction func loadAd(_ button: UIButton) {
        showActivityIndicator()
        loadButton?.isEnabled = false
        showButton?.isEnabled = false
        MPRewardedVideo.loadAd(withAdUnitID: Consts.AdUnitID.rewardedVideo, withMediationSettings: [])
    }

    @IBAction func showAd(_ button: UIButton) {
        guard MPRewardedVideo.hasAdAvailable(forAdUnitID: Consts.AdUnitID.rewardedVideo) else {
            return
        }

        guard let rewards = MPRewardedVideo.availableRewards(forAdUnitID: Consts.AdUnitID.rewardedVideo) as? [MPRewardedVideoReward],
            let reward = rewards.first else {
            return
        }

        MPRewardedVideo.presentAd(forAdUnitID: Consts.AdUnitID.rewardedVideo, from: self, with: reward)
    }

}

// MARK: - MPRewardedVideo Delegate

extension RewardedVideoViewController: MPRewardedVideoDelegate {

    func rewardedVideoAdDidLoad(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
        hideActivityIndicator()
        loadButton?.isEnabled = true
        showButton?.isEnabled = true
    }

    func rewardedVideoAdDidFailToLoad(forAdUnitID adUnitID: String!, error: Error!) {
        print(#function, adUnitID ?? "", error.localizedDescription)
        hideActivityIndicator()
        showAlert(message: error.localizedDescription)
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func rewardedVideoAdWillAppear(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
    }

    func rewardedVideoAdDidAppear(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
    }

    func rewardedVideoAdDidFailToPlay(forAdUnitID adUnitID: String!, error: Error!) {
        print(#function, adUnitID ?? "", error.localizedDescription)
        showAlert(message: error.localizedDescription)
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func rewardedVideoAdDidExpire(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
        showAlert(message: "expired")
        loadButton?.isEnabled = true
        showButton?.isEnabled = false
    }

    func rewardedVideoAdDidReceiveTapEvent(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
    }

    func rewardedVideoAdWillLeaveApplication(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
    }

    func rewardedVideoAdShouldReward(forAdUnitID adUnitID: String!, reward: MPRewardedVideoReward!) {
        print(#function, adUnitID ?? "")
        if let reward = reward {
            print("currencyType:    \(reward.currencyType ?? "")", "amount:    \(reward.amount.doubleValue)")
        }
    }

    func rewardedVideoAdWillDisappear(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
    }

    func rewardedVideoAdDidDisappear(forAdUnitID adUnitID: String!) {
        print(#function, adUnitID ?? "")
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
