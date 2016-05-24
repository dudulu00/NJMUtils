
#import "Config.h"


#import <UICKeyChainStore.h>
#import <Security/Security.h>

static NSString * const kService = @"myserver-domain";
//注册时返回的信息
static NSString * const kPhoneNum = @"";
static NSString * const kToken = @"";
static NSString * const kUserId = @"";
static NSString * const kUserName = @"";
static NSString * const kPassword = @"";

static NSString * const kAcctName = @"";
static NSString * const kIdNo = @"";
static NSString * const kGesturePass = @"";

static NSString * const kBankNumber = @"";

@implementation Config

//注册时存储信息
+ (void)savePhoneNum:(NSString *)phoneNum andToken:(NSString *)token
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    keychain[kPhoneNum] = phoneNum;
    keychain[kToken] = token;
}
+ (void)saveUserId:(NSString *)userId andUserName:(NSString *)userName
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    keychain[kUserId] = userId;
    keychain[kUserName] = userName;
}
+ (void)savePassWord:(NSString *)passWord
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    keychain[kPassword] = passWord;
}
+ (void)saveAcctName:(NSString *)acctName andIdNo:(NSString *)idNO
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    keychain[kAcctName] = acctName;
    keychain[kIdNo] = idNO;
}

+ (void)saveGesturePassword:(NSString *)gesturePass
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    keychain[kGesturePass] = gesturePass;
    
}

+ (void)saveBankNumber:(NSString *)bankNumber
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    
    keychain[kBankNumber] = bankNumber;
    
}

//在需要的地方获得用户信息
+ (NSString *)getPhoneNum
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *phoneNum = keychain[kPhoneNum];
    return phoneNum?:@"";
}
+ (NSString *)getToken
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *token = keychain[kToken];
    return token?:@"";
}

+ (NSString *)getUserId
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *userId = keychain[kUserId];
    return userId?:@"";
}
+ (NSString *)getUserName
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *userName = keychain[kUserName];
    return userName?:@"";
}
+ (NSString *)getPassWord
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *password = keychain[kPassword];
    return password?:@"";
}
+ (NSString *)getAcctName
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *AcctName = keychain[kAcctName];
    //NSString *nilStr = [NSString stringWithFormat:@"%@",nil];
    
    return AcctName?:@"";
}
+ (NSString *)getIdNo
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *IdNo = keychain[kIdNo];
    //NSString *nilStr = [NSString stringWithFormat:@"%@",[NSNull null]];
    
    return IdNo?:@"";
}

+ (NSString *)getBankNumber
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    
    NSString *bankNumber = keychain[kBankNumber];
    
    return bankNumber?:@"";
}

+ (NSString *)getGesturePassWord
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kService];
    NSString *gesturePassword = keychain[kGesturePass];
    return gesturePassword?:@"";
}


//删除用户信息
+(void)removePhoneNumAndToken {
    
    [UICKeyChainStore removeItemForKey:kPhoneNum service:kService];
    [UICKeyChainStore removeItemForKey:kToken service:kService];
    [UICKeyChainStore removeItemForKey:kUserName service:kService];
    [UICKeyChainStore removeItemForKey:kUserId service:kService];
    [UICKeyChainStore removeItemForKey:kPassword service:kService];
    
    [UICKeyChainStore removeItemForKey:kIdNo service:kService];
    [UICKeyChainStore removeItemForKey:kAcctName service:kService];
    [UICKeyChainStore removeItemForKey:kGesturePass service:kService];
    [UICKeyChainStore removeItemForKey:kBankNumber service:kService];
    
    [self removeGesturePassword];
}


+ (void)removeGesturePassword
{
    [UICKeyChainStore removeItemForKey:kGesturePass service:kService];
}

//判断登陆
+ (BOOL)isLogin
{
    return ![[self getToken]  isEqual: @""] || ![[self getPhoneNum]  isEqual: @""];
}


+ (void)printAllInfo
{
    NSLog(@"{ phone:%@\n token:%@\n userName(p):%@\n userId:%@\n password:%@\n realName:%@\n CardID:%@\n",[Config getPhoneNum],[Config getToken],[Config getUserName],[Config getUserId],[Config getPassWord],[Config getAcctName],[Config getIdNo]);
}

@end


