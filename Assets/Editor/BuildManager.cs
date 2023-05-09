using System.Collections;
using System.IO;
using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System;

public class BuildManager : Editor
{
    //在这里找出你当前工程所有的场景文件，假设你只想把部分的scene文件打包 那么这里可以写你的条件判断 总之返回一个字符串数组。
    static string[] GetBuildScenes()
    {
        List<string> names = new List<string>();
        foreach (EditorBuildSettingsScene e in EditorBuildSettings.scenes)
        {
            if (e == null)
                continue;
            if (e.enabled)
                names.Add(e.path);
        }
        return names.ToArray();
    }

    /// <summary>
    /// 自定义工程名："project-"作为工程名的前缀参数
    /// </summary>
    public static string projectName
    {
        get
        {
            foreach (string arg in System.Environment.GetCommandLineArgs())
            {
                if (arg.StartsWith("project"))
                {
                    return arg.Split("-"[0])[1];
                }
            }
            return Application.productName;
        }
    }

    /// <summary>
    /// 打包Android应用
    /// </summary>
    static void BuildForAndroid()
    {
        // 签名文件配置，若不配置，则使用Unity默认签名
        PlayerSettings.Android.keyaliasName = "demokey.keystore";
        PlayerSettings.Android.keyaliasPass = "123456";
        PlayerSettings.Android.keystoreName = Application.dataPath.Replace("/Assets", "") + "Plugins/Android/ShareSDK/demokey.keystore";
        PlayerSettings.Android.keystorePass = "123456";

        // APK路径、名字配置
        string apkName = DateTime.Now.ToString("yyyyMMdd_HHmmss");
        string path = Application.dataPath.Replace("/Assets", "") + "/APK/" + projectName + "_" + apkName + ".apk";
        BuildPipeline.BuildPlayer(GetBuildScenes(), path, BuildTarget.Android, BuildOptions.None);
    }
}