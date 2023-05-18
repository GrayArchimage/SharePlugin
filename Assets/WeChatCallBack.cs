using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WeChatCallBack : MonoBehaviour
{
    public void WechatLoginCallback(string callBackInfo)
    {
        // openid	    普通用户的标识，对当前开发者帐号唯一
        // nickname	    普通用户昵称
        // sex	        普通用户性别，1为男性，2为女性
        // province	    普通用户个人资料填写的省份
        // city	        普通用户个人资料填写的城市
        // country	    国家，如中国为CN
        // headimgurl    用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
        // privilege	    用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
        // unionid	    用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。多app数据互通保存该值
        // access_token  用户当前临时token值，自主添加的值
        if(string.IsNullOrEmpty(callBackInfo))
        {
            // TODO 登录失败，请重试
            Debug.Log("error!!");
        }
        else
        {
            Debug.Log(callBackInfo);
        }
    }
}
