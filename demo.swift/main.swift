//
//  main.swift
//  demo.swift
//
//  Created by zhubiao on 2021/8/16.
//

import Foundation

//打包环境名称
var environment:String = ""
//打包环境配置
var environmentSting:String = ""
//工程名称
var project = "z"


print(ANSIColors.red+"打包ipa开始!")

print(ANSIColors.green+"请选择需要打包环境: 1.测试环境  2.生产环境")

guard let response = readLine(),let number = Int(response) else{
    
    print(ANSIColors.red+"输入参数非法，程序结束")

   exit(0)
}

if(number == 1){
    environment = "测试环境"
    environmentSting = "Debug"
}else if(number == 2){
    environment = "生产环境"
    environmentSting = "Release"

}

ios_build();

func ios_build() -> Void{
  
    print(ANSIColors.green+"当前打包环境: \(environment) ")
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm"
    let dateString = dateFormatter.string(from: Date())
    
    let archivePath = "~/Library/Developer/Xcode/Archives/\(dateString)/z"

    let xcodebuild = "xcodebuild archive -workspace \(project).xcworkspace -scheme \(project) -configuration \(environmentSting) -archivePath \(archivePath) | xcpretty"
    
    runShell(xcodebuild)
    print(archivePath);
    print(ANSIColors.red+"***************开始导出ipa文件******************")
    
    let exportPath = "~/Desktop/\(project)-\(dateString)/";
    
    let exportIpa = "xcodebuild -exportArchive -archivePath \(archivePath).xcarchive -exportPath \(exportPath) -exportOptionsPlist ExportOptions.plist"
    runShell(exportIpa);
            
    print(ANSIColors.red+"****************ipa 导出完成********************")
    
}
