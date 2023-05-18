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

// 通过code换取token，此步实际项目是放在服务端执行
-(void)requestWxToken:(NSString*)code {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", mWXAppid, "你的APPSecret", code]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            [self requestWxUserInfo:[dict valueForKey:@"access_token"]];
        }
    }];
    
    [dataTask resume];
}

// 通过token查询用户信息，此步实际项目是放在服务端执行
-(void)requestWxUserInfo:(NSString*)token{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token, mWXAppid]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString *jsonStr = [self DataTOjsonString:dict];
            // 回调给Unity
            UnitySendMessage("SDKCallBack", "WeChatLoginCallback",[jsonStr UTF8String]);
        }
    }];
    
    [dataTask resume];
}

- (void)onReq:(BaseReq *)req {
	// TODO 微信回调，从微信端主动发送过来的请求
}

@end