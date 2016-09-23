# Lwt_ActionSheet
类似于系统的UIAlertSheet风格的选择表


###例子:
![](https://github.com/lwt211/Lwt_ActionSheet/raw/master/resource/IMG_2212.jpg) 
##如何使用？ 

###创建
Lwt_ActionSheet *actionSheet = /[[Lwt_ActionSheet alloc] initWithCancelBtnTitle:@"取消" <br/>destructiveButtonTitle:nil otherBtnTitlesArr:@[@"默认",@"最新",@"最热"] <br/>actionBlock:^(NSInteger clickIndex) {<br/>
<br/>
}];<br/>

###弹出
/[actionSheet show];

