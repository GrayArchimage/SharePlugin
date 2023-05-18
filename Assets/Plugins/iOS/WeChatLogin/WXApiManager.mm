#import "WXApiManager.h"

@implementation WXApiManager

// 单例
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)onResp:(BaseResp *)resp {
	if ([resp isKindOfClass:[SendAuthResp class]]) {
    		NSLog(@"微信授权回调");
    		if (resp.errCode == 0) {
    			// 通过code去交换token，此步需要用到APPSecret，这个字段非常敏感
    			// 实际项目此步是放在服务端执行，这里仅作为客户端演示
    			[self requestWxToken:((SendAuthResp *)resp).code];
    		}
    		else
    		{
    			// 失败，回调给Unity
    			UnitySendMessage("SDKCallBack", "WeChatLoginCallback", "");
    		}
    	}
}

- (void)onReq:(BaseReq *)req {
	// TODO 微信回调，从微信端主动发送过来的请求
}

@end