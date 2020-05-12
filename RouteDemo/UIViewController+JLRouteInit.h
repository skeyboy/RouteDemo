//
//  UIViewController+JLRouteInit.h
//  RouteDemo
//
//  Created by 李雨龙 on 2020/5/12.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JLRouteInit)

/// 默认从主项目加载
/// @param params <#params description#>
/// @param block <#block description#>
+(instancetype)initRouteParams:(NSDictionary *) params
                         block:(void(^)(UIViewController * viewController, NSDictionary *param)) block ;

/**
   
   采用static 需要将xib打包进framework中
   
   导入时： Build Phases
   静态库需要添加到 Copy Bundle Resources中
   
  图片资源加载方式 xxx.framework/xxx.png
 @note     UIImage *  image = [UIImage imageNamed:@"StaticVC.framework/img.png"];

   */
+(instancetype)initRouteParams:(NSDictionary *)params
           staticFrameworkName:(NSString *)frameworkName forStaticLibraryBlock:(void (^)(UIViewController * _Nonnull, NSDictionary * _Nonnull))block;


/// dynamic 设置
/// general 选择 Frameworks Libraries and Embeded Content
/// 选中对应的framework 然后 Embed选项选中 Embed Without Signing
/// @see  dyld: Library not loaded: @rpath/DynamicVC.framework/DynamicVC 问题解决参照 note
/// @note 目的是项目打包时打包至App下面的Frameworks文件夹下
/// @note 图片资源按照从mainbundle加载就行



+(instancetype)initRouteParams:(NSDictionary *)params
         forDyLibraryBlock:(void (^)(UIViewController * _Nonnull, NSDictionary * _Nonnull))block;

@end

NS_ASSUME_NONNULL_END
