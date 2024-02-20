//
//  ContentView.swift
//  02_SegmentView
//
//  Created by admin on 2024/2/19.
//

import SwiftUI

struct ContentView : View {
    @State var selectedIndex: Int = 1
    
    var body: some View {
        PageView(items: ["新闻", "咨询", "视频", "城市", "关注"], selectedIndex: $selectedIndex) { index in
           Text("第\(index)个页面")
        }
        .didSelect { index in
            print("选择了页面: ", index)
        }
    }
}

#Preview {
    ContentView()
}
