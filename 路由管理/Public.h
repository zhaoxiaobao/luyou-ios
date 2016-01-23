//
//  Header.h
//  路由管理
//
//  Created by zhaoyuan on 15/9/9.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#ifndef _____Header_h
#define _____Header_h


// 1.获得RGB颜色
#define white    [UIColor whiteColor]  

#define fontBlue    [UIColor colorWithRed:0.271f green:0.549f blue:0.922f alpha:1.00f]

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]


#define navigationBarColor [UIColor colorWithRed:0.475f green:0.122f blue:0.827f alpha:1.00f]

#define bgroundColor [UIColor colorWithRed:0.933f green:0.937f blue:0.941f alpha:1.00f]

// 2.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define bar_height [[UIApplication sharedApplication] statusBarFrame].size.height

//3.字体灰色

#define fontGray [UIColor colorWithRed:0.349f green:0.341f blue:0.345f alpha:1.00f]
#define fontWhite [UIColor whiteColor]



#endif
