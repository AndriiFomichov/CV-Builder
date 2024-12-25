//
//  BenefitsView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct BenefitsView: View {
    
    let benefitsId: Int
    
    var body: some View {
        VStack {
            
            switch benefitsId {
            case 0, 1:
                AiBenefitsView()
                ExportBenefitsView()
                QRBenefitsView()
            case 2:
                ExportBenefitsView()
                AiBenefitsView()
                QRBenefitsView()
            case 3:
                QRBenefitsView()
                AiBenefitsView()
                ExportBenefitsView()
            default:
                AiBenefitsView()
                ExportBenefitsView()
                QRBenefitsView()
            }
            
        }.frame(maxWidth: 464)
    }
}

struct AiBenefitsView: View {
    
    var body: some View {
        
        VStack {
            
            AIResumesBenefitView()
            
            HStack {
                
                AIAssistantBenefitView()
                
                AITextBenefitView()
                
            }.frame(height: 130).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            AICoverLetterBenefitView()
            
            AIBackRemoverBenefitView()
        }
    }
}

struct ExportBenefitsView: View {
    
    var body: some View {
        
        VStack {
            
            GeometryReader { geo in
                HStack {
                    
                    WatermarkBenefitView().frame(width: geo.size.width * 0.38)
                    
                    ExportBenefitView().frame(width: geo.size.width * 0.6)
                    
                }
            }.frame(height: 130).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct QRBenefitsView: View {
    
    var body: some View {
        
        VStack {
            
            QRBenefitView()
            
        }
    }
}

#Preview {
    BenefitsView(benefitsId: 0)
}
