// WeChatUnity.mm

#import <Foundation/Foundation.h>
#import "WXApiManager.h"

#define UNITY_CS_API extern "C"

static NSString *mWXAppid = nil;

// 将c字符串const char* 转为 oc字符串NSString
static inline NSString * str_c2ns(const char*s)
{
    if (s)
        return [NSString stringWithUTF8String: s];
    else
        return [NSString stringWithUTF8String: ""];
}

// 初始化
UNITY_CS_API void UnityWeChatInit(const char* appId, const char* universalLink)
{
	mWXAppid = str_c2ns(appId);
	[WXApi registerApp:mWXAppid universalLink:str_c2ns(universalLink)];
}

UNITY_CS_API void UnityWeChatLogin(const char* state)
{
    NSLog(@"UnityWeChatLogin");

    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";;
    req.state = str_c2ns(state);
    [WXApi sendReq:req completion:nil];
    // 此时会拉起微信，授权后会回调WXApiManager的onResp方法
}