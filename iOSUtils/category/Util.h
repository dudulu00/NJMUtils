
#import <Foundation/Foundation.h>
#import "SQDAPI.h"
#import "UIColor+Util.h"
#import "UIView+Util.h"
#import "UIImage+Util.h"
#import "UIImageView+Util.h"
#import "AFHTTPRequestOperationManager+Util.h"

@interface Util : NSObject

//通过颜色来生成一个纯色图片
+ (UIImage *)getImageFromColor:(UIColor *)color withFrame:(CGRect )frame;

+(CGSize)getSizeWithText:(NSString*)text fontOfSize:(int)fontSize boundingRectSize:(CGSize)rectSize;

+(NSDictionary*)getNetworkingBasicParamDicWithAttachParamDic:(NSDictionary*)attachParamDic;
//手机号
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;
+(NSString*)encryptRegisterNum:(NSString*)rNum;
//版本号
+(NSString*)getAppVersionNum;
//MD5加密
+ (NSString *)encryptMD5String:(NSString *)originalString;
//登录界面
+ (void)presentLoginViewControllerAtCurrentViewController:(UIViewController*)currentVc;
//hub
+ (void)showWaitingHUBWithMsg:(NSString *) msg detailMsg:(NSString *)detail;//带有等待提示动画 (show from window)
+ (void)showPromptHUBWithMsg:(NSString *)msg detailMsg:(NSString *)detail;//只是给出提示信息 (show from window)
//非模态
+ (void)showWaitingHUBWithMsg:(NSString *) msg detailMsg:(NSString *)detail fromView:(UIView *)view;//带有等待提示动画 (show from view)
+ (void)showPromptHUBWithMsg:(NSString *)msg detailMsg:(NSString *)detail fromView:(UIView *)view;//只是给出提示信息 (show from view)

+ (void)closeHUBView;
//服务器报错提示
+(void)showServerErrorMessage:(NSString*)errorMessage;
+(void)showNetErrorOrServerTimoutMessage;
@end
