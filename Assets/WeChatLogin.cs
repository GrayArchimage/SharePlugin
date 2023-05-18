using System.Runtime.InteropServices;

public class WeChatLogin
{
    public static void Init()
    {
#if UNITY_IOS
        UnityWeChatInit("wx617c77c82218ea2c", "d78e67a15f7e4cbfd124b22f9fc2acad.share2dlink.com");
#elif UNITY_ANDROID
        // TODO Android的调用
#endif
    }
    
#if UNITY_IOS
        [DllImport("__Internal")]
        static extern void UnityWeChatInit(string appId, string universalLink);
#endif
    
    public static void Login()
    {
#if UNITY_IOS
	// "app_wechat"后期改为随机数加session来校验
    UnityWeChatLogin("app_wechat");
#elif UNITY_ANDROID
    // TODO Android的调用
#endif
    }
    

#if UNITY_IOS
        [DllImport("__Internal")]
        static extern void UnityWeChatLogin(string state);
#endif
}
