//
//  ContentView.swift
//  SwiftUI-Videos
//
//  Created by dev22 jumpa on 21/11/22.
//

import SwiftUI

struct ContentView: View {
	
	var videos: [Video] = []
	
    var body: some View {
		NavigationView {
			List(videos) { video in
				HStack {
					Image(video.imageName)
						.resizable()
						.scaledToFit()
						.frame(height: 90)
						.cornerRadius(8)
					
					Spacer().frame(width: 16)
					
					VStack(alignment: .leading) {
						Text(video.title)
							.font(.headline)
							.fontWeight(.bold)
							.lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
						Spacer().frame(height: 5)
						Text(video.uploadDate)
							.font(.subheadline)
							.foregroundColor(.secondary)
					}
				}
			}
			.listStyle(.plain)
			.navigationTitle("Videos")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(videos: VideoList.topTwelve)
    }
}
