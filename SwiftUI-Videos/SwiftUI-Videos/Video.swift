//
//  Video.swift
//  SwiftUI-Videos
//
//  Created by dev22 jumpa on 21/11/22.
//

import Foundation

struct Video: Identifiable {
	var id = UUID()
	var imageName: String
	var title: String
	var uploadDate: String
}

struct VideoList {
	static let topTwelve = [
		Video(imageName: "37-tips", title: "37 TIps", uploadDate: "2022 Nov 21"),
		Video(imageName: "lazy", title: "Lazy", uploadDate: "2022 Nov 21"),
		Video(imageName: "portfolio", title: "Portofolio", uploadDate: "2022 Nov 21"),
		Video(imageName: "hired", title: "Hired", uploadDate: "2022 Nov 21"),
		Video(imageName: "average-dev", title: "Average Dev", uploadDate: "2022 Nov 21"),
		Video(imageName: "hig", title: "Hig", uploadDate: "2022 Nov 21"),
		Video(imageName: "child-vc", title: "Child VC", uploadDate: "2022 Nov 21"),
		Video(imageName: "aluna", title: "Aluna", uploadDate: "2022 Nov 21"),
		Video(imageName: "macaw", title: "Macaw", uploadDate: "2022 Nov 21"),
		Video(imageName: "90-90", title: "90 90", uploadDate: "2022 Nov 21"),
		Video(imageName: "2018-setup", title: "2018 Stup", uploadDate: "2022 Nov 21"),
	]
}
