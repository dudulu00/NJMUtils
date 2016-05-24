
#import <Foundation/Foundation.h>

@class ZBUser;

@interface Config : NSObject
//
+ (void)savePhoneNum:(NSString *)phoneNum andToken:(NSString *)token;
+ (void)saveUserId:(NSString *)userId andUserName:(NSString *)userName;
+ (void)savePassWord:(NSString *)passWord;

+ (void)saveAcctName:(NSString *)acctName andIdNo:(NSString *)idNO;
+ (void)saveGesturePassword:(NSString *)gesturePass;

+ (void)saveBankNumber:(NSString *)bankNumber;


+ (NSString *)getPhoneNum;
+ (NSString *)getToken;

+ (NSString *)getUserId;
+ (NSString *)getUserName;

+ (NSString *)getPassWord;

+ (NSString *)getAcctName;
+ (NSString *)getIdNo;
+ (NSString *)getBankNumber;

//获得手势密码
+ (NSString *)getGesturePassWord;
+ (void)removeGesturePassword;
//
+(void)removePhoneNumAndToken;
+ (BOOL)isLogin;

+ (void)printAllInfo;

@end
