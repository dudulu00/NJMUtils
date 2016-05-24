
#import "Util.h"
#import "RGProgressHUD.h"
#import "Config.h"
#import <CommonCrypto/CommonCrypto.h>
#import <AdSupport/AdSupport.h>

@implementation Util

//通过颜色来生成一个纯色图片
+ (UIImage *)getImageFromColor:(UIColor *)color withFrame:(CGRect )frame
{
    CGRect rect = frame;
    //    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//根据字符串长度获取label的size
+(CGSize)getSizeWithText:(NSString*)text fontOfSize:(int)fontSize boundingRectSize:(CGSize)rectSize
{
    CGSize size;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    size = [text boundingRectWithSize:rectSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;

    return size;
}
//获取版本号
+(NSString*)getAppVersionNum
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    app_Version = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    return app_Version;
}
//基本请求参数
+(NSDictionary*)getNetworkingBasicParamDicWithAttachParamDic:(NSDictionary*)attachParamDic {
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                  @"version":[Util getAppVersionNum],
                                  @"orderNo":@"0000",
                                  @"osType":@"iOS",
                                 
                                  @"token":[Config getToken],
                                  @"idfa": [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]
                                  
                                  }];
    
    [parameters addEntriesFromDictionary:attachParamDic];
    return parameters;

}

//是否是有效电话号
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber{
    if (![phoneNumber length]){
        return NO;
    }
    NSString * format = @"(^(\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [pred evaluateWithObject:phoneNumber];
}

//手机号加密算法
+(NSString*)encryptRegisterNum:(NSString*)rNum {
    NSMutableString *encryptedNum = [NSMutableString stringWithString:rNum];
    
    NSMutableString *reverseNum = [[NSMutableString alloc] initWithCapacity:rNum.length];
    for (NSInteger i = rNum.length - 1; i >=0 ; i --) {
        unichar ch = [rNum characterAtIndex:i];
        [reverseNum appendFormat:@"%c", ch];
    }
    [encryptedNum appendString:reverseNum];
    
    NSArray *zeroArray = @[@"a",@"0",@"1",@"3",@"6"];
    NSArray *oneArray = @[@"b", @"k", @"2", @"4", @"7"];
    NSArray *twoArray = @[@"c", @"l", @"t", @"5", @"8"];
    NSArray *threeArray = @[@"d", @"m", @"u", @"B", @"9"];
    NSArray *fourArray = @[@"e", @"n", @"v", @"C", @"I"];
    NSArray *fiveArray = @[@"f", @"o", @"w", @"D", @"J", @"O"];
    NSArray *sixArray = @[@"g", @"p", @"x", @"E", @"K", @"P", @"T"];
    NSArray *sevenArray = @[@"h", @"q", @"y", @"F", @"L", @"Q", @"U", @"X"];
    NSArray *eightArray = @[@"i", @"r", @"z", @"G", @"M", @"R", @"V", @"Y"];
    NSArray *nineArray = @[@"j", @"s", @"A", @"H", @"N", @"S", @"W", @"Z"];
    
    NSArray *arrays = @[zeroArray,oneArray,twoArray,threeArray,fourArray,fiveArray,sixArray,sevenArray,eightArray,nineArray];
    
    for (int j=0; j<encryptedNum.length; j++) {
        int charIndex = [[encryptedNum substringWithRange:NSMakeRange(j, 1)] intValue];
        NSArray *numArray = [arrays objectAtIndex:charIndex];
        [encryptedNum replaceCharactersInRange:NSMakeRange(j, 1) withString:[numArray objectAtIndex:arc4random()%numArray.count]];
    }
    return encryptedNum;
}

#pragma mark - MD5
+ (NSString *)encryptMD5String:(NSString *)originalString

{
    const char *cStr = [originalString UTF8String];
    
    unsigned char result[16];
    
    // This is the md5 call
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}

#pragma mark -- 登录界面弹出
+ (void)presentLoginViewControllerAtCurrentViewController:(UIViewController*)currentVc
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
    [currentVc presentViewController:navigationController animated:YES completion:^{
        
    }];
}

#pragma mark -- Waiting Dialog
static RGProgressHUD * s_hub = nil;

+ (void)showWaitingHUBWithMsg:(NSString *) msg detailMsg:(NSString *)detail{ //带有等待提示动画
    [Util showWaitingHUBWithMsg:msg detailMsg:detail fromView:nil];
}


+ (void)showPromptHUBWithMsg:(NSString *)msg detailMsg:(NSString *)detail{ //只是给出提示信息
    [Util showPromptHUBWithMsg:msg detailMsg:detail fromView:nil];
}


+ (void)showWaitingHUBWithMsg:(NSString *) msg detailMsg:(NSString *)detail fromView:(UIView *)view{//带有等待提示动画 (show from view)
    
    if (s_hub) {
        [Util closeHUBView];
    }
    RGProgressHUD * hub = [[RGProgressHUD alloc] initWithView:view];
    s_hub = hub;
    
    [s_hub showWaitingDialogWithMessage:msg detailMessage:detail];
}

+ (void)showPromptHUBWithMsg:(NSString *)msg detailMsg:(NSString *)detail fromView:(UIView *)view{//只是给出提示信息 (show from view)
    if (s_hub) {
        [Util closeHUBView];
    }
    
    RGProgressHUD * hub = [[RGProgressHUD alloc] initWithView:nil];
    s_hub = hub;
    
    [s_hub showMessage:msg detailMessage:detail];
}

+ (void)closeHUBView{
    if (s_hub) {
        [s_hub hide];
        s_hub = nil;
    }
}

//服务器报错提示
+(void)showServerErrorMessage:(NSString*)errorMessage
{
    if ([errorMessage length] == 0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [Util showPromptHUBWithMsg:@"服务器打了个盹，马上回来" detailMsg:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Util closeHUBView];
            });
        });
        
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([errorMessage length]>16) {
                [Util showPromptHUBWithMsg:nil detailMsg:errorMessage];
            }else{
                [Util showPromptHUBWithMsg:errorMessage detailMsg:nil];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Util closeHUBView];
            });
        });
    }
    
}
+(void)showNetErrorOrServerTimoutMessage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [Util showPromptHUBWithMsg:@"未连接到服务器，请先检查一下网络" detailMsg:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Util closeHUBView];
        });
    });
}




@end
