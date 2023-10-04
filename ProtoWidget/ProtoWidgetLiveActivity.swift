//
//  ProtoWidgetLiveActivity.swift
//  ProtoWidget
//
//  Created by vlad on 21/09/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ProtoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ProtoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ProtoWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ProtoWidgetAttributes {
    static var preview: ProtoWidgetAttributes {
        ProtoWidgetAttributes(name: "World")
    }
}

extension ProtoWidgetAttributes.ContentState {
    static var smiley: ProtoWidgetAttributes.ContentState {
        ProtoWidgetAttributes.ContentState(emoji: "😀")
     }

     static var starEyes: ProtoWidgetAttributes.ContentState {
         ProtoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ProtoWidgetAttributes.preview) {
   ProtoWidgetLiveActivity()
} contentStates: {
    ProtoWidgetAttributes.ContentState.smiley
    ProtoWidgetAttributes.ContentState.starEyes
}
