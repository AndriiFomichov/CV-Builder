//
//  ProgressBarPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 06.12.2024.
//

import SwiftUI

struct ProgressBarPreviewView: View {
    
    var progress: Int
    var steps: Int
    var height: Int
    var style: Int
    var accentColor: String
    var backgroundColor: String
    var cornersRadius: CGFloat
    
    var body: some View {
        ZStack {
            if style == 0 {
                StarsProgressBarPreviewView(progress: progress, steps: steps, height: height, accentColor: accentColor, backgroundColor: backgroundColor)
            } else if style == 1 {
                LineProgressBarPreviewView(progress: progress, steps: steps, height: height, accentColor: accentColor, backgroundColor: backgroundColor, cornersRadius: cornersRadius)
            } else if style == 2 {
                ThumbProgressBarPreviewView(progress: progress, steps: steps, height: height, accentColor: accentColor, backgroundColor: backgroundColor, cornersRadius: cornersRadius)
            } else if style == 3 {
                DotsProgressBarPreviewView(progress: progress, steps: steps, height: height, accentColor: accentColor, backgroundColor: backgroundColor)
            }
        }
    }
}

struct StarsProgressBarPreviewView: View {
    
    var progress: Int
    var steps: Int
    var height: Int
    var accentColor: String
    var backgroundColor: String
    
    var body: some View {
        HStack (spacing: 1) {
            ForEach(0..<steps, id: \.self) { step in
                Image(systemName: "star.fill").font(.system(size: CGFloat(height), weight: .medium, design: .default)).foregroundStyle(Color(hex: progress >= step ? accentColor : backgroundColor))
            }
        }.frame(height: CGFloat(height))
    }
}

struct LineProgressBarPreviewView: View {
    
    var progress: Int
    var steps: Int
    var height: Int
    var accentColor: String
    var backgroundColor: String
    var cornersRadius: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .leading) {
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: backgroundColor)).padding(1)
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: accentColor)).frame(width: geo.size.width * (Double(progress) / Double(steps)))
            }
        }.frame(height: CGFloat(height))
    }
}

struct ThumbProgressBarPreviewView: View {
    
    var progress: Int
    var steps: Int
    var height: Int
    var accentColor: String
    var backgroundColor: String
    var cornersRadius: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .leading) {
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: backgroundColor)).stroke(Color(hex: accentColor), style: StrokeStyle(lineWidth: CGFloat(height / 6)))
                
                Circle().fill(Color(hex: accentColor)).offset(x: calculateOffset(width: geo.size.width))
                
                
            }
        }.frame(height: CGFloat(height))
    }
    
    private func calculateOffset (width: CGFloat) -> CGFloat {
        if progress == 0 {
            return 0.0
        } else if progress == steps {
            return width - CGFloat(height)
        } else {
            return width * (Double(progress) / Double(steps)) - CGFloat(height / 2)
        }
    }
}

struct DotsProgressBarPreviewView: View {
    
    var progress: Int
    var steps: Int
    var height: Int
    var accentColor: String
    var backgroundColor: String
    
    var body: some View {
        HStack (spacing: 4) {
            ForEach(0..<steps, id: \.self) { step in
                Circle().fill(Color(hex: progress >= step ? accentColor : backgroundColor)).frame(height: CGFloat(height) * 0.8)
            }
        }.frame(height: CGFloat(height))
    }
}

#Preview {
    ProgressBarPreviewView(progress: 1, steps: 4, height: 16, style: 0, accentColor: "#FFAC45", backgroundColor: "#ACFFFF", cornersRadius: 12.0)
}
