//
//  ContentView.swift
//  Control Center
//
//  Created by Jordan Singer on 6/28/20.
//

import SwiftUI

struct ContentView: View {
    @State var volume = 0.0
    var body: some View {
        ZStack {
            EffectsView(material: NSVisualEffectView.Material.popover, blendingMode: NSVisualEffectView.BlendingMode.behindWindow)
            
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        Setting(title: "Wi-Fi", subtitle: "Home", image: "wifi")
                        Setting(title: "Bluetooth", subtitle: "On", image: "airpodspro")
                        Setting(title: "AirDrop", subtitle: "Contacts Only", image: "dot.radiowaves.right")
                    }
                    .modifier(ModulePadding())
                    .frame(width: 134, height: 134)
                    .modifier(Module())
                    
                    VStack(spacing: 10) {
                        Setting(title: "Do Not Disturb", image: "moon.fill")
                            .modifier(ModulePadding())
                            .modifier(Module())
                        
                        HStack(spacing: 10) {
                            SmallSetting(title: "Keyboard Brightness", image: "sun.min")
                            SmallSetting(title: "Airplay Display", image: "airplayvideo")
                        }
                    }
                    .frame(width: 134, height: 134)
                }
                
                VStack(spacing: 10) {
                    Control(title: "Display", image: "ipad.landscape")
                    Control(title: "Sound", image: "airplayaudio")
                }
            }
            .padding()
        }
        .frame(width: 297, height: 305)
    }
}

struct Setting: View {
    @State var title: String
    @State var subtitle: String?
    @State var image: String
    
    var body: some View {
        HStack {
            Ellipse()
                .foregroundColor(Color(NSColor.systemBlue))
                .overlay(
                    Image(systemName: image)
                        .foregroundColor(.white)
                )
                .frame(width: 28, height: 28)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                if subtitle != nil {
                    Text(subtitle ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color(NSColor.secondaryLabelColor))
                }
            }
            
            Spacer()
        }
    }
}

struct SmallSetting: View {
    @State var title: String
    @State var image: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(NSColor.secondaryLabelColor))
            Text(title)
                .multilineTextAlignment(.center)
                .font(.caption)
        }
        .frame(width: 62, height: 62)
        .modifier(Module())
    }
}

struct Control: View {
    @State var title: String
    @State var image: String
    @State var value = 0.5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
            
            HStack(spacing: 8) {
                Slider(value: $value)
                    .accentColor(.red)
                
                Image(systemName: image)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(NSColor.secondaryLabelColor))
                .frame(width: 28, height: 28)
                    .background(EffectsView(material: NSVisualEffectView.Material.popover, blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
                    .cornerRadius(14)
            }
        }
        .padding(9)
        .modifier(Module())
    }
}

struct Module: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(EffectsView(material: NSVisualEffectView.Material.popover, blendingMode: NSVisualEffectView.BlendingMode.withinWindow))
            .cornerRadius(10)
    }
}

struct ModulePadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 9)
            .padding(.vertical, 12)
    }
}

// blur effect
struct EffectsView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }

    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
