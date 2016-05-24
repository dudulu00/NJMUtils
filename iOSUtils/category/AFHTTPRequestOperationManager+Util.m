

#import "AFHTTPRequestOperationManager+Util.h"

@implementation AFHTTPRequestOperationManager (Util)

+ (instancetype)SQDNetworkingManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    return manager;
}
@end
