
//
//  JLHeader.h
//  WKWebView的Demo
//
//  Created by 杨建亮 on 2017/10/16.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#ifndef JLHeader_h
#define JLHeader_h

/**

 将UIWebViewDelegate和UIWebView重构成了14个类与3个协议官方链接
 Classes:
 * WKBackForwardList: 之前访问过的 web 页面的列表，可以通过后退和前进动作来访问到。
 * WKBackForwardListItem: webview 中后退列表里的某一个网页。
 * WKFrameInfo: 包含一个网页的布局信息。
 * WKNavigation: 包含一个网页的加载进度信息。
 * WKNavigationAction: 包含可能让网页导航变化的信息，用于判断是否做出导航变化。
 * WKNavigationResponse: 包含可能让网页导航变化的返回内容信息，用于判断是否做出导航变化。
 * WKPreferences: 概括一个 webview 的偏好设置。
 * WKProcessPool: 表示一个 web 内容加载池。
 * WKUserContentController: 提供使用 JavaScript post 信息和注射 script 的方法。
 * WKScriptMessage: 包含网页发出的信息。
 * WKUserScript: 表示可以被网页接受的用户脚本。
 * WKWebViewConfiguration: 初始化 webview 的设置。
 * WKWindowFeatures: 指定加载新网页时的窗口属性。
 Protocols
 * WKNavigationDelegate: 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
 * WKScriptMessageHandler: 提供从网页中收消息的回调方法。
 * WKUIDelegate: 提供用原生控件显示网页的方法回调。
 ----------------------------------------------------------------------------------------------------------------------------
 #import <WebKit/WKBackForwardList.h>
 #import <WebKit/WKBackForwardListItem.h>
 #import <WebKit/WKContentRuleList.h>
 #import <WebKit/WKContentRuleListStore.h>
 #import <WebKit/WKError.h>
 #import <WebKit/WKFoundation.h>
 #import <WebKit/WKFrameInfo.h>
 #import <WebKit/WKHTTPCookieStore.h>
 #import <WebKit/WKNavigation.h>
 #import <WebKit/WKNavigationAction.h>
 #import <WebKit/WKNavigationDelegate.h>
 #import <WebKit/WKNavigationResponse.h>
 #import <WebKit/WKOpenPanelParameters.h>
 #import <WebKit/WKPreferences.h>
 #import <WebKit/WKPreviewActionItem.h>
 #import <WebKit/WKPreviewActionItemIdentifiers.h>
 #import <WebKit/WKPreviewElementInfo.h>
 #import <WebKit/WKProcessPool.h>
 #import <WebKit/WKScriptMessage.h>
 #import <WebKit/WKScriptMessageHandler.h>
 #import <WebKit/WKSecurityOrigin.h>
 #import <WebKit/WKUIDelegate.h>
 #import <WebKit/WKURLSchemeHandler.h>
 #import <WebKit/WKURLSchemeTask.h>
 #import <WebKit/WKUserContentController.h>
 #import <WebKit/WKUserScript.h>
 #import <WebKit/WKWebView.h>
 #import <WebKit/WKWebViewConfiguration.h>
 #import <WebKit/WKWebsiteDataRecord.h>
 #import <WebKit/WKWebsiteDataStore.h>
 #import <WebKit/WKWindowFeatures.h>
 #import <WebKit/WebKitLegacy.h>
 
*/

#endif /* JLHeader_h */
