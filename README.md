# RouteDemo
JLRoute方式简易组件化调研实例，实例中加载两个组件采用framework方式加载

# 基础
## 路由注册
采用Appdelegate添加类目 使用initialize来加载【因此需要注意】
## UIViewController通用加载方式,采用Category方式提供加载了main ， static library  dynamic library中的VC加载

*注意*类目会根据编译顺序加载而initialize只会加载一次，因此需要避免在其他库的Appdelegate地方使用initialize，防止路由无法被注册

```

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
```

*无论是静态库还是动态库都十分需要注意资源文件的加载*




# 静态库制作


公开库暴漏对外调用方式
Build Phases中需要 Headers设置Public Private Project分别代表需要暴漏出的级别，一目了然不太过多说明
主要是需要考虑public的文件头，给外部调用使用
## 1 StaticVC.h中添加需要暴漏出去头h文件
```

#import <Foundation/Foundation.h>

//! Project version number for StaticVC.
FOUNDATION_EXPORT double StaticVCVersionNumber;

//! Project version string for StaticVC.
FOUNDATION_EXPORT const unsigned char StaticVCVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <StaticVC/PublicHeader.h>
#import <StaticVC/StaticViewController.h>


```
## 2 导入设置
正常拖入到项目中之外还需注意一个地方---将对应静态库 添加到Build Phases下的 Copy Bundle Resources中
## 3 静态文件读取加载注意事项（nib xib也是资源文件）

静态库需要使用需要注意
1 资源加载 xxx.framework/xxx资源的方式，
2 制作是需要将对应资源文件添加到 Build Phases中的 Copy Bundle Resources中


# 动态库制作

资源加载可以采用常规的方式加载

## 项目导入

General 中 Framework ,Libraries, and Embedded Content 中需要将对应动态库的Content设置为 Embed……

