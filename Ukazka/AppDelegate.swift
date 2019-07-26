//
//  AppDelegate.swift
//  Ukazka
//
//  Created by Jiří Chlum on 23/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        self.window = window
        self.window?.makeKeyAndVisible()
        return true
    }
}

class AppCoordinator: Coordinator {

    let window: UIWindow

    private let campaignRepository: CampaignsRepositoable

    private var rootController: UINavigationController!

    init(window: UIWindow) {
        self.window = window
        let mockSettings = MockSettings(delayType: .exact(value: 1.0))
        let responseDataProvider = MockResponseDataProvider()
        let provider = MockRequestProvider(settings: mockSettings, dataProvider: responseDataProvider)
        let services = CampaignsService(provider: provider)
        self.campaignRepository = CampaignsRepository(service: services)
    }

    override func start() {
        startAppFlow()
    }

    private func startAppFlow() {
        let controller = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        let mainController = MainViewController(campaignsLoader: campaignRepository)
        mainController.delegate = self
        controller.setViewControllers([mainController], animated: true)
        window.rootViewController = controller
        rootController = controller
    }

}

extension AppCoordinator: MainViewControllerDelegate {

    func didSelect(campaign: Campaign) {
        let controller = DetailViewController(campaignId: campaign.id, campaignLoader: campaignRepository)
        rootController.pushViewController(controller, animated: true)
    }
}
